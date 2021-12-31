import 'dart:async';

import 'package:app_logger/app_logger.dart';
import 'package:bristol_app/app/domain/bloc/app_store.dart';
import 'package:bristol_app/app/domain/model/app_state.dart';
import 'package:bristol_app/app/domain/model/async_field.dart';
import 'package:bristol_app/features/geolocation/domain/geolocation_service.dart';
import 'package:bristol_app/features/locations/domain/repository/location_repository.dart';
import 'package:bristol_app/features/shops/data/model/region_shops.dart';
import 'package:bristol_app/features/shops/domain/model/near_shops_state.dart';
import 'package:bristol_app/features/shops/domain/repository/shop_repository.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

export 'package:bristol_app/features/shops/domain/model/near_shops_state.dart';

enum ShopListScreenMode { chooseShop, closestShops }

class NearShopsCubit extends Cubit<NearShopsState> {
  final ShopsRepository shopsRepository;
  final GeolocationService geolocationService;
  final AppStore appStore;
  final ShopListScreenMode shopListScreenMode;
  final LocationsRepository locationsRepository;

  late final StreamSubscription<AppState> appStateSub;

  NearShopsCubit({
    required this.shopsRepository,
    required this.geolocationService,
    required this.shopListScreenMode,
    required this.appStore,
    required this.locationsRepository,
  }) : super(NearShopsState()) {
    appStateSub = appStore.stream.listen((event) {
      final appStoreCity = event.location?.city;
      if (appStoreCity != null &&
          appStoreCity != state.location?.payload?.city) {
        loadRegionShops();
        if (event.location != null) {
          emit(state.rebuild((s) {
            s.location.replace(AsyncField.success(event.location!));
          }));
        }
      }
    });
  }

  @override
  Future<void> close() {
    appStateSub.cancel();
    return super.close();
  }

  Future<void> init() async {
    emit(state.rebuild((s) {
      s.location.replace(AsyncField.inProgress());
    }));
    final position = await geolocationService.getLastPosition();
    final location = appStore.state.location;
    if (location != null) {
      emit(state.rebuild((s) {
        s.location.replace(AsyncField.success(location));
      }));
    } else {
      if (position != null) {
        await onUserPositionUpdate(position);
      } else {
        emit(state.rebuild((s) {
          s.location.replace(AsyncField.error('location not found'));
        }));
      }
    }

    /// если нет доступа к геолокации, то вместо страницы "Ближайшие магазины"
    /// мы отображаем страницу "Выбрать магазин"
    if (shopListScreenMode == ShopListScreenMode.closestShops &&
        position != null) {
      emit(
        state.rebuild((s) => s.nearShopMode = ShopListScreenMode.closestShops),
      );
    } else {
      emit(
        state.rebuild((s) => s.nearShopMode = ShopListScreenMode.chooseShop),
      );
    }
    await loadRegionShops();
  }

  Future<void> loadRegionShops() async {
    emit(state.rebuild((s) {
      s.shopsListField.replace(AsyncField.inProgress());
    }));
    try {
      final newShops = await _loadShops();
      emit(state.rebuild((s) {
        s.shopsListField.replace(AsyncField.success(BuiltList.of(newShops)));
      }));
    } catch (error) {
      if (error is Error) {
        emit(state.rebuild((s) {
          s.shopsListField.replace(AsyncField.error(error));
        }));
      } else {
        logException(error);
      }
    }
  }

  Future<void> onUserPositionUpdate(LatLng position) async {
    try {
      final location = await locationsRepository.fetchLocation(position);
      if (location != null) {
        emit(state.rebuild((s) {
          s.location.replace(AsyncField.success(location));
        }));
        await appStore.pickLocation(location);
      }
    } catch (e) {
      logException(e);
      emit(state.rebuild((s) {
        s.location.replace(AsyncField.error(e));
      }));
    }
  }

  Future<Iterable<RegionShops>> _loadShops() async {
    /// страница "Выбрать магазин" действует только по локации
    if (!state.usesGeoLocation) {
      return shopsRepository.getNearRegionsShopsList(
        maxShopsAmount: state.maxShopsAmount,
        cityId: appStore.state.pickedCity?.id.toString(),
      );
    }

    /// страница "Ближайшие магазины" работает по геолокации
    /// если есть доступ к ней
    try {
      /// TODO: добавить сортировку по расстоянию
      return shopsRepository.getNearRegionsShopsList(
        userLocation: await geolocationService.getLastPosition(),
        maxShopsAmount: state.maxShopsAmount,
      );
    } catch (_) {
      /// catch стоит на случай если [geolocationService.getLastPosition()]
      /// выдаст ошибку при определении геолокации
      return shopsRepository.getNearRegionsShopsList(
        maxShopsAmount: state.maxShopsAmount,
        cityId: appStore.state.pickedCity?.id.toString(),
      );
    }
  }
}
