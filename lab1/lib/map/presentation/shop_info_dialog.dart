import 'package:bristol_app/app/presentation/components/box.dart';
import 'package:bristol_app/app/presentation/components/buttons/filled_raised_button.dart';
import 'package:bristol_app/app/presentation/components/loading_skeletons/shimmer_loading.dart';
import 'package:bristol_app/app/presentation/components/loading_skeletons/skeleton.dart';
import 'package:bristol_app/app/presentation/styles/colors.dart';
import 'package:bristol_app/app/presentation/styles/text_styles.dart';
import 'package:bristol_app/di/service_locator.dart';
import 'package:bristol_app/features/shops/data/model/detailed_shop.dart';
import 'package:bristol_app/features/shops/data/model/shop.dart';
import 'package:bristol_app/features/shops/domain/repository/shop_repository.dart';
import 'package:bristol_app/utils/dialog.dart';
import 'package:bristol_app/utils/typedefs.dart';
import 'package:flutter/material.dart';

import 'list/shop_tile_temporary_work_hours.dart';
import 'widgets/shop_banner.dart';

Future<Shop?> showShopInfoBottomSheet(
  BuildContext context, {
  OnItemSelected<DetailedShop?>? onShopSelected,
  String? buttonText,
  required int shopId,
}) {
  return showModalBottomSheet<Shop>(
      context: context,
      backgroundColor: Theme.of(context).backgroundColor,
      useRootNavigator: true,
      barrierColor: Colors.transparent,
      routeSettings: RouteSettings(name: 'ShopInfoDialog_id:$shopId'),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BottomDialogTongue(),
            SafeArea(
                child: _ShopCardInfoLoader(
              shopId,
              onShopSelected: onShopSelected,
              buttonText: buttonText,
            )),
          ],
        );
      });
}

class _ShopCardInfoLoader extends StatelessWidget {
  const _ShopCardInfoLoader(
    this.shopId, {
    Key? key,
    this.onShopSelected,
    this.buttonText,
  }) : super(key: key);

  final int shopId;

  final OnItemSelected<DetailedShop?>? onShopSelected;

  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DetailedShop>(
        future: locator.get<ShopsRepository>().getShop(shopId),
        builder: (ctx, state) {
          if (state.hasData) {
            return ShopCardInfo(
              state.data!,
              onShopSelected: onShopSelected,
              buttonText: buttonText,
            );
          }
          return _ShopCardInfoSkeleton();
        });
  }
}

class _ShopCardInfoSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.6;
    return Shimmer(
      child: ShimmerLoading(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SkeletonLoader(height: 22, width: width),
              const HBox(7),
              SkeletonLoader(height: 18, width: width),
              const HBox(32),
              const SkeletonLoader(height: 54, radius: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class ShopCardInfo extends StatelessWidget {
  const ShopCardInfo(
    this.detailedShop, {
    Key? key,
    this.onShopSelected,
    this.buttonText,
  }) : super(key: key);

  final DetailedShop detailedShop;

  final OnItemSelected<DetailedShop?>? onShopSelected;

  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    final _detailedShop = detailedShop;
    final shop = detailedShop.shop;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(shop?.address ?? '',
              style: Theme.of(context).textTheme.subtitle2),
          if (shop?.scheduleOfficial?.formatted != null)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                shop!.scheduleOfficial!.formatted!,
                style: AppTextStyles.textAppearanceCaption.copyWith(
                  color: BristolColors.onyx,
                ),
              ),
            ),
          if (shop?.temporaryWorksHours?.formatted != null &&
              shop?.showTemporaryWorksHours == true)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: ShopTileTemporaryWorkHours(
                temporaryWorkHours: shop!.temporaryWorksHours!.formatted!,
              ),
            ),
          if (shop?.bannerLink != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: ShopBanner(link: shop!.bannerLink!),
            ),
          const HBox(24),
          BristolFilledRaisedButton(
            title: buttonText ?? 'Посмотреть промоакции',
            onPressed: () {
              onShopSelected?.call(context, _detailedShop);
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
