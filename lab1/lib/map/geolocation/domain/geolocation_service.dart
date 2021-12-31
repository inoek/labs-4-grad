import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class GeolocationService {
  Future<LatLng?> getCurrentPosition();

  Future<LatLng?> getLastPosition();

  double? distanceBetween(LatLng? firstPosition, LatLng? secondPosition);

  Future<LocationPermission?> checkGeolocationPermissionStatus();

  Future<LocationPermission?> requestPermission();

  Stream<LatLng> get positionUpdate;
}
