import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lab1/map/domain/bloc/shops_map_cubit.dart';

class ShopMapController {
  final BuildContext context;

  ShopMapController(this.mapCubit, this.context, {this.onMarkersUpdated}) {
    controllerCompleter.future.then((controller) {
      _manager?.setMapController(controller);
      _googleMapController = controller;
    });
    // listen
    _shopListSubscription = mapCubit.stream
        .distinct((a, b) => a.listUpdatedTimeStamp == b.listUpdatedTimeStamp)
        .listen(_onShopListEdited);

    _selectedShopSubscription = mapCubit.stream
        .distinct((a, b) => a.selectedShopMarker == b.selectedShopMarker)
        .listen(_onSelectedShopMarkerUpdated);

    _devicePositionSubscription = mapCubit.stream
        .distinct((a, b) => a.cameraPositionModel == b.cameraPositionModel)
        .listen(_onBoundsUpdated);
  }

  final ShopsMapCubit mapCubit;

  final VoidCallback? onMarkersUpdated;

  TextStyle? _clusterTextStyle;

  Set<Marker>? _markers;

  Set<Marker>? get markers => _markers;

  BitmapDescriptor? _defIcon;

  BitmapDescriptor? _pickedIcon;

  final Completer<GoogleMapController> controllerCompleter =
      Completer<GoogleMapController>();

  GoogleMapController? _googleMapController;

  GoogleMapController? get controller => _googleMapController;

  LatLng get initialPosition => const LatLng(55.749092, 37.629180);

  //подписка на выбранный магазин
  StreamSubscription? _selectedShopSubscription;

  // подписка на изменения списка магазинов
  StreamSubscription? _shopListSubscription;

  // подписка на обновление координат устройства
  StreamSubscription? _devicePositionSubscription;

  void dispose() {
    _selectedShopSubscription?.cancel();
    _shopListSubscription?.cancel();
    _devicePositionSubscription?.cancel();
    _googleMapController?.dispose();
  }

  void _onBoundsUpdated(ShopsMapState state) {
    logJust('_onUserLocationUpdated');
    final model = state.cameraPositionModel;
    final position = model?.position;
    if (position != null && state.selectedShopMarker == null) {
      ///фокус на регионе
      if (model?.initCameraZoom == CameraPositionModel.regionZoom) {
        _googleMapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: position.southwest,
              zoom: 8,
            ),
          ),
        );
      } else {
        _googleMapController?.animateCamera(
          CameraUpdate.newLatLngBounds(position, 100),
        );
      }
    }
  }
}
