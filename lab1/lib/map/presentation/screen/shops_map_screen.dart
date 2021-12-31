import 'package:bristol_app/app/domain/bloc/app_store.dart';
import 'package:bristol_app/app/domain/model/app_state.dart';
import 'package:bristol_app/app/presentation/components/app_bar/bristol_app_bar.dart';
import 'package:bristol_app/di/service_locator.dart';
import 'package:bristol_app/features/app_errors/presentation/error_modal.dart';
import 'package:bristol_app/features/geolocation/domain/geolocation_service.dart';
import 'package:bristol_app/features/shops/data/model/detailed_shop.dart';
import 'package:bristol_app/features/shops/data/model/shop.dart';
import 'package:bristol_app/features/shops/domain/bloc/shops_map_cubit.dart';
import 'package:bristol_app/features/shops/domain/model/shops_map_state.dart';
import 'package:bristol_app/features/shops/presentation/check_geolocation_status_flow.dart';
import 'package:bristol_app/features/shops/presentation/map/shops_map.dart';
import 'package:bristol_app/features/shops/presentation/widgets/map_search_button.dart';
import 'package:bristol_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uikit/friflex_utils.dart';

import '../shop_info_dialog.dart';
import 'near_shops_screen.dart';

abstract class ShopsMapScreen extends StatelessWidget {
  const ShopsMapScreen({Key? key}) : super(key: key);

  String? get appBarTitle => null;

  Widget? get appBarLeading => null;

  String? get buttonText => 'Посмотреть промоакции';

  bool? get showAppBar => true;

  ///usually just search
  WidgetBuilder? get topSection => (context) => const Positioned(
        top: 8.0,
        left: 16,
        right: 16,
        child: MapSearchButton(),
      );

  Widget onCreateProvider(BuildContext context);

  @protected
  void onShopSelected(BuildContext context, DetailedShop detailedShop);

  @override
  Widget build(BuildContext context) {
    return onCreateProvider(context);
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 'navigation',
          onPressed: () async {
            final geoService = locator.get<GeolocationService>();
            await startCheckLocationFlow(context, geoService: geoService)
                .then((value) async {
              await context
                  .read<ShopsMapCubit>()
                  .calculateBounds(requestIfDenied: true);
            });
          },
          mini: true,
          backgroundColor: Colors.white,
          child: Assets.icons.navigation.svg(),
        ),
        FloatingActionButton(
          heroTag: 'menu',
          onPressed: () {
            NearShopsScreen.showClosestShopsScreen(context).then((shop) {
              if (shop != null && shop is Shop) {
                runWithDelay(action: () {
                  context.read<ShopsMapCubit>().pickCurrentShop(shop);
                });
              }
            });
          },
          mini: true,
          backgroundColor: Colors.white,
          child: Assets.icons.menu.svg(),
        ),
      ],
    );
  }

  Widget onBuild(BuildContext context) {
    return Scaffold(
      appBar: showAppBar == true
          ? buildAppBar(context, title: appBarTitle, leading: appBarLeading)
          : const PreferredSize(
              preferredSize: Size.zero,
              child: SizedBox.shrink(),
            ),
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (context) => MultiBlocListener(
          listeners: [
            BlocListener<AppStore, AppState>(
              listener: (context, state) {
                context.read<ShopsMapCubit>().fetchShopMarkers();
              },
              listenWhen: (last, current) =>
                  last.location?.city?.id != current.location?.city?.id,
            ),
            BlocListener<ShopsMapCubit, ShopsMapState>(
              listener: (context, state) {
                if (state.selectedShopMarker != null) {
                  showShopInfoBottomSheet(context,
                      shopId: state.selectedShopMarker!.id,
                      buttonText: buttonText, onShopSelected: (ctx, shop) {
                    if (shop != null) {
                      runWithDelay(action: () {
                        onShopSelected.call(context, shop);
                      });
                    }
                  }).then((value) {
                    context.read<ShopsMapCubit>().clearPickedShop();
                  });
                }
              },
              listenWhen: (a, b) =>
                  a.selectedShopMarker != b.selectedShopMarker,
            ),
            BlocListener<ShopsMapCubit, ShopsMapState>(
              listenWhen: (previous, current) =>
                  current.progressState?.error != previous.progressState?.error,
              listener: (context, state) {
                if (state.progressState?.error != null) {
                  showShopLoadErrorModal(
                    context: context,
                    onRefresh: () {
                      context.read<ShopsMapCubit>().fetchShopMarkers();
                    },
                  );
                }
              },
            ),
          ],
          child: Stack(
            children: [
              SizedBox.expand(child: ShopsMap(context.watch<ShopsMapCubit>())),
              Align(
                  alignment: const Alignment(0.98, 0.1),
                  child: _buildButtons(context)),
              topSection != null
                  ? topSection!(context)
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
