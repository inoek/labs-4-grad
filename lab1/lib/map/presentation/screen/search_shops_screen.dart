import 'package:bristol_app/app/app/presentation/debouce.dart';
import 'package:bristol_app/app/presentation/components/bottom_safe_area.dart';
import 'package:bristol_app/app/presentation/components/box.dart';
import 'package:bristol_app/app/presentation/components/loading_skeletons/skeleton.dart';
import 'package:bristol_app/app/presentation/routing/navigator.dart';
import 'package:bristol_app/app/presentation/styles/text_themes.dart';
import 'package:bristol_app/di/service_locator.dart';
import 'package:bristol_app/features/shops/data/model/shop.dart';
import 'package:bristol_app/features/shops/domain/bloc/shops_search_cubit.dart';
import 'package:bristol_app/features/shops/domain/model/shops_search_state.dart';
import 'package:bristol_app/features/shops/domain/repository/shop_repository.dart';
import 'package:bristol_app/features/shops/presentation/list/builder_delegate.dart';
import 'package:bristol_app/features/shops/presentation/search_field.dart';
import 'package:bristol_app/generated/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchShopScreen extends StatelessWidget {
  const SearchShopScreen({Key? key}) : super(key: key);

  static Future<Shop?> show(BuildContext context) {
    final screen = BlocProvider<ShopsSearchCubit>(
      create: (_) {
        final repository = locator.get<ShopsRepository>();
        return ShopsSearchCubit(repository);
      },
      child: const SearchShopScreen(),
    );
    return navigatorPush(context, screen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            splashRadius: 16,
            icon: Assets.icons.arrowBack.svg(),
            onPressed: () => navigatorPop(context)),
        titleSpacing: 2,
        title: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: SearchField(
            placeholder: 'Город, улица...',
            onChanged: (value) {
              context.read<ShopsSearchCubit>().setQuery(value);
              Debounce.debounce('delayed search suggestions', () {
                context.read<ShopsSearchCubit>().searchShops();
              }, duration: const Duration(milliseconds: 300));
            },
          ),
        ),
      ),
      body: BottomSafeArea(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<ShopsSearchCubit, ShopsSearchState>(
      buildWhen: (a, b) => a.shopsField != b.shopsField,
      builder: (context, state) {
        if (state.shopsField.connectionState == ConnectionState.waiting) {
          return ListView.builder(
            itemBuilder: (_, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HBox(19),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Flexible(child: SkeletonLoader(height: 19, width: 206)),
                    SkeletonLoader(height: 19, width: 38),
                  ],
                ),
                const HBox(4),
                Row(
                  children: const [
                    SkeletonLoader(height: 14, width: 219),
                  ],
                ),
                const HBox(16),
              ],
            ),
            itemCount: 10,
          );
        }

        if (state.shopsField.data?.isEmpty == true) {
          return Align(
            alignment: const Alignment(0.0, -0.9),
            child: Text('Ничего не нашлось', style: onyx06TextTheme.bodyText1),
          );
        }

        if (state.shopsField.hasData) {
          return ListView.custom(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            childrenDelegate: ShopListSliverBuilderDelegate(
              state.shopsField.data!,
              onItemSelected: _onItemSelected,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _onItemSelected(BuildContext context, Shop item) {
    navigatorPop(context, item);
  }
}
