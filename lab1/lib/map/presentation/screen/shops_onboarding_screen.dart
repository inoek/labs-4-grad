import 'package:bristol_app/app/domain/bloc/app_store.dart';
import 'package:bristol_app/app/presentation/routing/navigator.dart';
import 'package:bristol_app/app/presentation/screens/root_screen.dart';
import 'package:bristol_app/di/service_locator.dart';
import 'package:bristol_app/features/geolocation/domain/geolocation_service.dart';
import 'package:bristol_app/features/locations/data/model/location.dart';
import 'package:bristol_app/features/shops/data/model/detailed_shop.dart';
import 'package:bristol_app/features/shops/domain/bloc/shops_map_cubit.dart';
import 'package:bristol_app/features/shops/presentation/screen/shops_map_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uikit/friflex_utils.dart';

import '../check_geolocation_status_flow.dart';

class ShopsMapOnBoardingWrapper extends StatefulWidget {
  /// чтобы не вызывать проверку локации повторно
  final bool disableCheckGeolocationFlow;

  const ShopsMapOnBoardingWrapper({
    Key? key,
    this.disableCheckGeolocationFlow = false,
  }) : super(key: key);

  @override
  _ShopsMapOnBoardingWrapperState createState() =>
      _ShopsMapOnBoardingWrapperState();
}

class _ShopsMapOnBoardingWrapperState extends State<ShopsMapOnBoardingWrapper> {
  @override
  void initState() {
    if (!widget.disableCheckGeolocationFlow) {
      final geoService = locator.get<GeolocationService>();
      runWithDelay(
        action: () =>
            geoService.checkGeolocationPermissionStatus().then((value) {
          startCheckLocationFlow(
            context,
            geoService: geoService,
          );
        }),
        duration: const Duration(milliseconds: 200),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const ShopsMapOnBoardingScreen();
  }
}

class ShopsMapOnBoardingScreen extends ShopsMapScreen {
  const ShopsMapOnBoardingScreen({Key? key}) : super(key: key);

  @override
  String get appBarTitle => 'Выбрать магазин';

  @override
  Widget? get appBarLeading => null;

  @override
  String? get buttonText => 'Перейти в каталог';

  @override
  void onShopSelected(BuildContext context, DetailedShop detailedShop) {
    final appStore = context.read<AppStore>();
    if (detailedShop.shop != null &&
        detailedShop.region != null &&
        detailedShop.city != null) {
      appStore.pickShop(detailedShop.shop!);
      appStore.pickLocation(Location((l) {
        l.city.replace(detailedShop.city!);
        l.region.replace(detailedShop.region!);
      }));
      navigatorReplace(context, const RootScreen());
    }
  }

  @override
  Widget onCreateProvider(BuildContext context) {
    return BlocProvider<ShopsMapCubit>(
      create: (_) => ShopsMapCubit(
        appStore: locator.get<AppStore>(),
      )..fetchShopMarkers(),
      child: onBuild(context),
    );
  }
}
