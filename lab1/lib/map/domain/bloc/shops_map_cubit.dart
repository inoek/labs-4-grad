import 'package:app_logger/app_logger.dart';
import 'package:bloc/bloc.dart';
import 'package:bristol_app/app/domain/bloc/app_store.dart';
import 'package:bristol_app/app/domain/model/async_field.dart';
import 'package:bristol_app/di/service_locator.dart';
import 'package:bristol_app/features/geolocation/domain/geolocation_service.dart';
import 'package:bristol_app/features/shops/data/model/shop.dart';
import 'package:bristol_app/features/shops/data/model/shop_marker.dart';
import 'package:bristol_app/features/shops/domain/model/camera_position_model.dart';
import 'package:bristol_app/features/shops/domain/model/shops_map_state.dart';
import 'package:bristol_app/features/shops/domain/repository/shop_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uikit/friflex_utils.dart';

class ShopsMapCubit extends Cubit<ShopsMapState> {
  ShopsMapCubit({
    required this.appStore,
  }) : super(ShopsMapState());

  final AppStore appStore;

  List<ShopMarker>? _shopMarkersList;

  List<ShopMarker>? get shopList => _shopMarkersList;

  void pickCurrentShop(Shop? shop) {
    if (shop == null) return;
    if (_shopMarkersList?.isNotEmpty != true) {
      fetchShopMarkers().then((_) {
        pickShop(shop);
      });
    } else {
      runWithDelay(
        action: () => pickShop(shop),
      );
    }
  }

  Future<void> setCustomMarkers(List<ShopMarker>? customMarkers) {
    emit(state.rebuild((s) {
      s.listUpdatedTimeStamp = DateTime.now().toIso8601String();
    }));
    return runWithDelay(
      action: () {
        calculateBounds(customMarkers: customMarkers);
      },
      duration: const Duration(milliseconds: 600),
    );
  }

  Future<void> fetchShopMarkers({
    Shop? pickedShop,
  }) {
    emit(state.rebuild((s) {
      s.progressState.replace(AsyncField<bool>.inProgress());
    }));
    final cityId = appStore.state.location?.city?.id;

    return locator
        .get<ShopsRepository>()
        .getShopMarkers(cityId: cityId)
        .then((shops) {
      _shopMarkersList = shops.toList();
      emit(state.rebuild((s) {
        s.listUpdatedTimeStamp = DateTime.now().toIso8601String();
      }));
      if (pickedShop != null) {
        runWithDelay(
          action: () => pickShop(pickedShop),
        );
      } else {
        runWithDelay(
          action: () {
            calculateBounds();
          },
          duration: const Duration(milliseconds: 500),
        );
      }
    }).catchError((error) {
      emit(state.rebuild((s) {
        s.progressState.replace(AsyncField<bool>.error(error));
      }));
    });
  }

  void pickMarker(ShopMarker shopMarker) {
    emit(state.rebuild((s) {
      s.selectedShopMarker.replace(shopMarker);
    }));
  }

  void pickShop(Shop shop) {
    emit(state.rebuild((s) {
      s.selectedShopMarker.replace(ShopMarker.fromShop(shop));
    }));
  }

  void clearPickedShop() {
    emit(state.rebuild((s) {
      s.selectedShopMarker = null;
    }));
  }

  Future<void> updateDeviceLocation({
    required LocationPermission? status,
    bool requestIfDenied = false,
  }) async {
    if (status != LocationPermission.always &&
        status != LocationPermission.whileInUse) {
      return;
    }

    final last = await locator.get<GeolocationService>().getLastPosition();
    if (last != null) {
      emit(state.rebuild((s) {
        s.userLocation = last;
      }));
    }
    final position =
        await locator.get<GeolocationService>().getCurrentPosition();
    if (position != null) {
      emit(state.rebuild((s) {
        s.userLocation = last;
      }));
    }
  }

  Future<void> calculateBounds({
    bool requestIfDenied = false,
    List<ShopMarker>? customMarkers,
  }) async {
    final status = await locator
        .get<GeolocationService>()
        .checkGeolocationPermissionStatus();
    if (customMarkers?.isNotEmpty == true) {
      _shopMarkersList = customMarkers;
    }
    if (state.userLocation == null) {
      await updateDeviceLocation(
              requestIfDenied: requestIfDenied, status: status)
          .catchError((error) {});
    }

    try {
      emit(state.rebuild((s) {
        s.cameraPositionModel = null;
      }));
    } catch (e) {
      logException(e);
    }

    final coords = await _getNearestShop(_shopMarkersList, state.userLocation)
        .catchError((e) {
      logException(e);
    });
    if (coords != null && customMarkers?.isNotEmpty != true) {
      _updateCameraPositionModel(
        coords: _boundsFromLatLngList(
          [state.userLocation, coords.position],
        ),
      );
    } else if (state.userLocation != null &&
        customMarkers?.isNotEmpty != true) {
      _updateCameraPositionModel(
        coords: _boundsFromLatLngList(
          [state.userLocation, state.userLocation],
        ),
      );
    }

    ///фокус на первом магазе в где купить
    else if (customMarkers?.isNotEmpty == true) {
      _updateCameraPositionModel(
          coords: _boundsFromLatLngList([customMarkers?.first.position]),
          zoom: CameraPositionModel.regionZoom);
    }

    ///фокус на ближайшем регионе
    ///если нет текущей гео, неактивна модалка с магазом
    else if (coords == null &&
        appStore.state.location?.city?.id != null &&
        state.selectedShopMarker == null &&
        customMarkers?.isNotEmpty != true) {
      _updateCameraPositionModel(
        coords: _boundsFromLatLngList([_shopMarkersList?.first.position]),
        zoom: CameraPositionModel.regionZoom,
      );
    }
  }

  void _updateCameraPositionModel({
    required LatLngBounds? coords,
    double zoom = CameraPositionModel.userZoom,
  }) {
    emit(state.rebuild((s) {
      s.cameraPositionModel = CameraPositionModel(
        position: coords,
        initCameraZoom: zoom,
      );
    }));
  }

  Future<ShopMarker?> _getNearestShop(
      Iterable<ShopMarker>? source, LatLng? userLocation) async {
    if (userLocation == null || source == null) return null;
    final service = locator.get<GeolocationService>();
    final sorted = source.fold<ShopMarker>(source.first, (a, b) {
      return service.distanceBetween(b.position, userLocation)! >
              service.distanceBetween(a.position!, userLocation)!
          ? a
          : b;
    });
    return sorted;
  }

  LatLngBounds? _boundsFromLatLngList(List<LatLng?> list) {
    double? x0, x1, y0, y1;
    for (var latLng in list) {
      if (latLng == null) continue;
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
        northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }
}
