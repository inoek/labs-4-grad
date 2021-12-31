import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:bristol_app/features/shops/data/model/shop.dart';
import 'package:bristol_app/features/shops/domain/repository/shop_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:uikit/friflex_utils.dart';

import '../model/shops_search_state.dart';

class ShopsSearchCubit extends Cubit<ShopsSearchState> {
  final ShopsRepository repository;

  ShopsSearchCubit(this.repository) : super(const ShopsSearchState());

  CancelableOperation? _fetchShopsTask;

  Future<void> searchShops() async {
    if (StringUtils.isNullOrEmpty(state.query)) return;
    await _fetchShopsTask?.cancel();
    if (state.query!.length > 2) {
      _updateShopsField(const AsyncSnapshot.waiting());

      try {
        _fetchShopsTask = CancelableOperation.fromFuture(
          repository.searchShops(state.query),
        );
        _updateShopsField(
          AsyncSnapshot.withData(
            ConnectionState.done,
            await _fetchShopsTask?.value,
          ),
        );
      } catch (error) {
        _updateShopsField(AsyncSnapshot.withError(ConnectionState.done, error));
      }
    }
    _fetchShopsTask = null;
  }

  void setQuery(String? query) {
    if (query == state.query) return;
    if (StringUtils.isNullOrEmpty(query)) {
      emit(state.copyWith(query: null));
      return;
    }
    emit(state.copyWith(query: query));
  }

  void _updateShopsField(AsyncSnapshot<List<Shop>> field) {
    emit(state.copyWith(shopsField: field));
  }
}
