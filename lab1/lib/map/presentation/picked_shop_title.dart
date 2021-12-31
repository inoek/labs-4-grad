import 'package:bristol_app/app/domain/bloc/app_store.dart';
import 'package:bristol_app/app/domain/model/app_state.dart';
import 'package:bristol_app/app/presentation/routing/router.dart';
import 'package:bristol_app/app/presentation/styles/colors.dart';
import 'package:bristol_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickedShopTitle extends StatelessWidget {
  const PickedShopTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppStore, AppState>(builder: (_, state) {
      if (state.pickedShop == null) {
        return const SizedBox();
      }
      return InkWell(
        onTap: () {
          AppRouter.current.openTab(RouterTab.shopMap);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  state.pickedShop?.address ?? '',
                  maxLines: 3,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: BristolColors.main),
                ),
              ),
              Assets.icons.arrowRight.svg(color: BristolColors.main)
            ],
          ),
        ),
      );
    });
  }
}
