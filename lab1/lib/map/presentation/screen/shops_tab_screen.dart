import 'package:bristol_app/app/domain/bloc/app_store.dart';
import 'package:bristol_app/app/presentation/routing/router.dart';
import 'package:bristol_app/di/service_locator.dart';
import 'package:bristol_app/features/shops/data/model/detailed_shop.dart';
import 'package:bristol_app/features/shops/domain/bloc/shops_map_cubit.dart';
import 'package:bristol_app/features/shops/domain/bloc/tabbed_shop_map_cubit.dart';
import 'package:bristol_app/features/shops/presentation/screen/shops_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopsMapTabScreen extends ShopsMapScreen {
  const ShopsMapTabScreen({Key? key}) : super(key: key);

  @override
  String get appBarTitle => 'Магазины';

  @override
  String? get buttonText => 'Перейти в каталог';

  @override
  void onShopSelected(BuildContext context, DetailedShop detailedShop) {
    locator.get<AppStore>().pickDetailedShop(detailedShop).then((_) {
      AppRouter.current.openTab(RouterTab.catalog);
    });
  }

  @override
  Widget get appBarLeading => const SizedBox();

  @override
  Widget onCreateProvider(BuildContext context) {
    return BlocProvider<ShopsMapCubit>.value(
      value: locator.get<TabbedShopMapCubit>()..fetchShopMarkers(),
      child: onBuild(context),
    );
  }
}
