import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:lab1/map/geolocation/domain/geolocation_service.dart';

@Singleton(as: GeolocationService)
class GeolocationServiceImpl extends GeolocationService {
  final StreamController<LatLng> _positionController =
      StreamController.broadcast();

  @override
  Stream<LatLng> get positionUpdate => _positionController.stream;

  @override
  Future<LatLng?> getLastPosition() async {
    try {
      final position = await Geolocator.getLastKnownPosition();
      final result = position?.latLng();
      if (result != null) {
        _positionController.add(result);
      }
      return result;
    } catch (e) {
      /// если пользователь не дал доступа к гео локации
      /// метод getLastKnownPosition выкинет ошибку
      return null;
    }
  }

  @override
  Future<LatLng?> getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final result = position.latLng();
    _positionController.add(result);
    return result;
  }

  @override
  double? distanceBetween(LatLng? firstPosition, LatLng? secondPosition) {
    if (firstPosition?.latitude == null ||
        secondPosition?.latitude == null ||
        firstPosition?.longitude == null ||
        secondPosition?.longitude == null) {
      return null;
    }

    return Geolocator.distanceBetween(
      firstPosition!.latitude,
      firstPosition.longitude,
      secondPosition!.latitude,
      secondPosition.longitude,
    );
  }

  @override
  Future<LocationPermission?> checkGeolocationPermissionStatus(
          {bool requestIfDenied = true}) =>
      Geolocator.checkPermission();

  @override
  Future<LocationPermission?> requestPermission() =>
      Geolocator.requestPermission();
}

extension PositionLatLng on Position {
  LatLng latLng() {
    return LatLng(latitude, longitude);
  }
}
