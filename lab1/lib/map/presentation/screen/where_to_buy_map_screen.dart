import 'package:bristol_app/app/domain/bloc/app_store.dart';
import 'package:bristol_app/di/service_locator.dart';
import 'package:bristol_app/features/shops/data/model/detailed_shop.dart';
import 'package:bristol_app/features/shops/data/model/shop_marker.dart';
import 'package:bristol_app/features/shops/domain/bloc/shops_map_cubit.dart';
import 'package:bristol_app/features/shops/presentation/screen/shops_map_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WhereToBuyMapScreen extends ShopsMapScreen {
  const WhereToBuyMapScreen(
    this.markers, {
    Key? key,
    this.onShopSelectedCallback,
  }) : super(key: key);
  final List<ShopMarker> markers;

  final ValueChanged<DetailedShop>? onShopSelectedCallback;

  @override
  bool? get showAppBar => false;

  @override
  String? get buttonText => 'Выбрать этот магазин';

  @override
  Widget onCreateProvider(BuildContext context) => BlocProvider<ShopsMapCubit>(
        create: (_) => ShopsMapCubit(
          appStore: locator.get<AppStore>(),
        )..setCustomMarkers(markers),
        child: onBuild(context),
      );

  @override
  void onShopSelected(BuildContext context, DetailedShop detailedShop) =>
      onShopSelectedCallback?.call(detailedShop);
}
