import 'package:bristol_app/app/domain/bloc/app_store.dart';
import 'package:bristol_app/features/shops/domain/bloc/shops_map_cubit.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class TabbedShopMapCubit extends ShopsMapCubit {
  TabbedShopMapCubit({
    required AppStore appStore,
  }) : super(appStore: appStore);
}
