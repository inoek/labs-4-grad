import 'package:bristol_app/app/domain/model/async_field.dart';
import 'package:bristol_app/features/shops/data/model/shop_marker.dart';
import 'package:bristol_app/features/shops/domain/model/camera_position_model.dart';
import 'package:built_value/built_value.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'shops_map_state.g.dart';

abstract class ShopsMapState
    implements Built<ShopsMapState, ShopsMapStateBuilder> {
  ShopsMapState._();

  factory ShopsMapState([void Function(ShopsMapStateBuilder) updates]) =
      _$ShopsMapState;

  @BuiltValueField(serialize: false)
  AsyncField<bool>? get progressState;

  // нужно для отслеживания обновления списка
  // т.е filteredList compare = false
  @BuiltValueField()
  String? get listUpdatedTimeStamp;

  CameraPositionModel? get cameraPositionModel;

  ShopMarker? get selectedShopMarker;

  LatLng? get userLocation;
}
