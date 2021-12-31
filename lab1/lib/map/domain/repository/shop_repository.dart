import 'package:bristol_app/features/shops/data/model/detailed_shop.dart';
import 'package:bristol_app/features/shops/data/model/region_shops.dart';
import 'package:bristol_app/features/shops/data/model/shop.dart';
import 'package:bristol_app/features/shops/data/model/shop_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class ShopsRepository {
  Future<Iterable<ShopMarker>> getShopMarkers({int? cityId});

  Future<Iterable<Shop>> getShopList({LatLng? userLocation});

  Future<DetailedShop> getShop(int id);

  Future<Iterable<Shop>> getNearestShopList(
      {LatLng center, double radiusMeters = 100000});

  Future<Iterable<RegionShops>> getNearRegionsShopsList({
    LatLng? userLocation,
    String? cityId,
    int? maxShopsAmount,
  });

  Future<Iterable<Shop>> searchShops(String? query);
}
