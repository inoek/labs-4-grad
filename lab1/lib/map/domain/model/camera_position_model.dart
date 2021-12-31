import 'package:google_maps_flutter/google_maps_flutter.dart';

class CameraPositionModel {
  static const regionZoom = 7.0;
  static const userZoom = 12.0;

  const CameraPositionModel({
    required this.position,
    required this.initCameraZoom,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CameraPositionModel &&
          runtimeType == other.runtimeType &&
          position == other.position &&
          initCameraZoom == other.initCameraZoom;

  @override
  int get hashCode => position.hashCode ^ initCameraZoom.hashCode;

  final double initCameraZoom;
  final LatLngBounds? position;
}
