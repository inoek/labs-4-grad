import 'package:bristol_app/app/domain/bloc/app_store.dart';
import 'package:bristol_app/app/presentation/routing/navigator.dart';
import 'package:bristol_app/di/service_locator.dart';
import 'package:bristol_app/features/shops/data/model/detailed_shop.dart';
import 'package:bristol_app/features/shops/domain/bloc/shops_map_cubit.dart';
import 'package:bristol_app/features/shops/presentation/screen/shops_map_screen.dart';
import 'package:bristol_app/features/shops/presentation/widgets/shops_picker_map_top_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ShopsPickerScreenType { changeOnPreviousScreen, saveToAppStore }

class ShopsPickerScreen extends ShopsMapScreen {
  const ShopsPickerScreen({
    this.type = ShopsPickerScreenType.saveToAppStore,
    Key? key,
  }) : super(key: key);
  final ShopsPickerScreenType type;

  @override
  String? get appBarTitle => 'Выбрать магазин';

  @override
  String? get buttonText => 'Выбрать';

  @override
  Widget? get appBarLeading => null;

  @override
  bool? get showAppBar => false;

  @override
  WidgetBuilder? get topSection =>
      (context) => const ShopsPickerMapTopSection();

  @override
  void onShopSelected(BuildContext context, DetailedShop detailedShop) {
    _onShopSelected(context, detailedShop: detailedShop);
  }

  @override
  Widget onCreateProvider(BuildContext context) {
    final appStore = locator.get<AppStore>();
    return BlocProvider<ShopsMapCubit>(
      create: (_) => ShopsMapCubit(
        appStore: appStore,
      )..pickCurrentShop(appStore.state.pickedShop),
      child: onBuild(context),
    );
  }

  void _onShopSelected(
    BuildContext context, {
    required DetailedShop detailedShop,
  }) {
    if (type == ShopsPickerScreenType.saveToAppStore) {
      locator.get<AppStore>().pickDetailedShop(detailedShop).then((_) {
        navigatorPop(context);
      });
    } else if (type == ShopsPickerScreenType.changeOnPreviousScreen) {
      navigatorPop(context, detailedShop);
    }
  }
}
