import 'package:bristol_app/features/shops/data/model/shop.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shops_search_state.freezed.dart';

@freezed
class ShopsSearchState with _$ShopsSearchState {
  const factory ShopsSearchState({
    String? query,
    @Default(AsyncSnapshot.nothing()) AsyncSnapshot<List<Shop>> shopsField,
  }) = _ShopsSearchState;
}
