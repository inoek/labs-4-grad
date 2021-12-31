import 'package:bristol_app/app/domain/model/async_field.dart';
import 'package:bristol_app/features/locations/data/model/location.dart';
import 'package:bristol_app/features/shops/data/model/region_shops.dart';
import 'package:bristol_app/features/shops/domain/bloc/near_shops_cubit.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'near_shops_state.g.dart';

abstract class NearShopsState
    implements Built<NearShopsState, NearShopsStateBuilder> {
  NearShopsState._();

  factory NearShopsState([void Function(NearShopsStateBuilder) updates]) =
      _$NearShopsState;

  AsyncField<BuiltList<RegionShops>>? get shopsListField;

  ShopListScreenMode? get nearShopMode;

  AsyncField<Location>? get location;
}

extension ClosestShopStateHelper on NearShopsState {
  bool get hasData => shopsListField?.hasData == true;

  bool get enableSearchButton => nearShopMode == ShopListScreenMode.chooseShop;

  int? get maxShopsAmount =>
      nearShopMode == ShopListScreenMode.closestShops ? 20 : null;

  String get title => nearShopMode == ShopListScreenMode.closestShops
      ? 'Ближайшие магазины'
      : 'Выбрать магазин';

  bool get usesGeoLocation => nearShopMode == ShopListScreenMode.closestShops;
}
