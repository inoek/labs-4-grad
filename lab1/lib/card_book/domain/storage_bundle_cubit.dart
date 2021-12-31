import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lab1/card_book/domain/person_bundle.dart';
import 'package:lab1/card_book/domain/storage_bundle_state.dart';
import 'package:lab1/local_storage.dart';
import 'package:lab1/service_locator.dart';

@Injectable()
class StorageBundleCubit extends Cubit<StorageBundleState> {
  static const bundleKey = 'key';

  StorageBundleCubit() : super(StorageBundleState());

  Future<void> fetch() {
    _onFieldUpdate(const AsyncSnapshot.waiting());
    return locator.get<LocalStorage>().read(bundleKey).then((value) {
      if (value != null) {
        _onFieldUpdate(AsyncSnapshot.withData(ConnectionState.done, value));
      }
    }).catchError((error) {
      _onFieldUpdate(AsyncSnapshot.withError(ConnectionState.done, error));
    });
  }

  void _onFieldUpdate(AsyncSnapshot<Iterable<PersonBundle>>? field) {
    emit(state.copyWith(field: field));
  }
}
