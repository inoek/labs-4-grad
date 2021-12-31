import 'package:bristol_app/app/domain/bloc/app_store.dart';
import 'package:bristol_app/app/presentation/components/app_bar/bristol_app_bar.dart';
import 'package:bristol_app/app/presentation/components/box.dart';
import 'package:bristol_app/app/presentation/components/buttons/filled_raised_button.dart';
import 'package:bristol_app/app/presentation/components/buttons/search_button.dart';
import 'package:bristol_app/app/presentation/components/loading_skeletons/shimmer_loading.dart';
import 'package:bristol_app/app/presentation/default_padding.dart';
import 'package:bristol_app/app/presentation/routing/navigator.dart';
import 'package:bristol_app/app/presentation/styles/colors.dart';
import 'package:bristol_app/app/presentation/styles/text_styles.dart';
import 'package:bristol_app/app/presentation/widgets/change_location_button.dart';
import 'package:bristol_app/di/service_locator.dart';
import 'package:bristol_app/features/app_errors/presentation/app_bloc_builder.dart';
import 'package:bristol_app/features/geolocation/domain/geolocation_service.dart';
import 'package:bristol_app/features/locations/domain/repository/location_repository.dart';
import 'package:bristol_app/features/locations/presentation/screens/change_region_screen.dart';
import 'package:bristol_app/features/shops/data/model/shop.dart';
import 'package:bristol_app/features/shops/domain/bloc/near_shops_cubit.dart';
import 'package:bristol_app/features/shops/domain/repository/shop_repository.dart';
import 'package:bristol_app/features/shops/presentation/list/builder_delegate.dart';
import 'package:bristol_app/features/shops/presentation/screen/search_shops_screen.dart';
import 'package:bristol_app/features/shops/presentation/widgets/shops_list_builder.dart';
import 'package:bristol_app/generated/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearShopsScreen extends StatelessWidget {
  static Future showChooseShopScreen(BuildContext context) => _show(
      context,
      const NearShopsScreen(
        desiredMode: ShopListScreenMode.chooseShop,
      ));

  static Future showClosestShopsScreen(BuildContext context) => _show(
      context,
      const NearShopsScreen(
        desiredMode: ShopListScreenMode.closestShops,
      ));

  static Future _show(BuildContext context, NearShopsScreen screen) =>
      navigatorPush(context, screen);

  /// переменная называется desired - потому что нет гарантии,
  /// что режим будет таким какой был указан.
  /// Это связано с тем, что если при входе на страницу "Ближайшие магазины"
  /// нет доступа к геолокации - приложение должно отобразить страницу
  /// "Выбрать магазин"
  /// То есть меняет режим страницы
  final ShopListScreenMode desiredMode;

  const NearShopsScreen({
    Key? key,
    required this.desiredMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NearShopsCubit>(
      /// важная строка кода, она заставит запуститься init метод
      /// который должен будет обновить локацию на основе геопозиции
      lazy: false,
      create: (_) => NearShopsCubit(
        shopsRepository: locator.get<ShopsRepository>(),
        geolocationService: locator.get<GeolocationService>(),
        shopListScreenMode: desiredMode,
        appStore: locator.get<AppStore>(),
        locationsRepository: locator.get<LocationsRepository>(),
      )..init(),
      child: const _NearShopsScreenBody(),
    );
  }
}

class _NearShopsScreenBody extends StatelessWidget {
  const _NearShopsScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBlocBuilder<NearShopsCubit, NearShopsState>(builder: (_, state) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: buildAppBar(context, title: state.title),
        backgroundColor: BristolColors.white,
        body: Builder(
          builder: (_) {
            if (state.location?.isLoading == true ||
                state.shopsListField?.isLoading == true) {
              return _buildLoadingView();
            }

            /// выбранный город и регион должны быть всегда
            /// если пользователь дал свою геопозицию - делается запрос на сервер
            /// который вернет регион и город
            /// если не дал свою геопозицию - то происходит "игра в города"
            if (state.location?.payload?.region == null ||
                state.location?.payload?.city == null) {
              return Padding(
                padding: defaultListPadding,
                child: _buildLocationNotFoundView(context),
              );
            }
            if (state.shopsListField?.hasData == true) {
              return _buildBody();
            }
            return const SizedBox.shrink();
          },
        ),
      );
    });
  }

  Widget _buildBody() {
    return AppBlocBuilder<NearShopsCubit, NearShopsState>(
      builder: (context, state) {
        final searchButton = Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: SearchButton(
            title: 'Поиск...',
            backgroundColor: BristolColors.white,
            onTap: () => SearchShopScreen.show(context).then(
              (shop) {
                if (shop != null) {
                  _onItemSelected(context, shop: shop);
                }
              },
            ),
          ),
        );
        final needShowSearch =
            state.nearShopMode == ShopListScreenMode.chooseShop;
        if (state.shopsListField?.payload?.isEmpty == true) {
          return _buildShopListIsEmpty(searchButton);
        }
        if (state.shopsListField?.payload?.isNotEmpty == true) {
          return Column(
            children: [
              searchButton,
              const HBox(16),
              ShopsListBuilder(
                regionShops: state.shopsListField!.payload!.toList(),
                onItemSelected: (context, shop) => _onItemSelected(
                  context,
                  shop: shop,
                ),
              ),
            ],
          );
        }

        ///таков путь
        return needShowSearch ? searchButton : const SizedBox.shrink();
      },
    );
  }

  Widget _buildLoadingView() {
    return Shimmer(
      child: ListView(
        padding: defaultListPadding,
        children: [...List.generate(20, (index) => buildShopsListSkeleton())],
      ),
    );
  }

  Widget _buildLocationNotFoundView(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(child: Assets.icons.shopBigIcon.svg()),
          Text('Магазин не найден', style: textTheme.subtitle1),
          const HBox(16),
          Text(
            'Магазин поблизости не найден, '
            'выберите регион для отображения списка магазинов',
            textAlign: TextAlign.center,
            style: textTheme.bodyText1,
          ),
          const HBox(48),
          BristolFilledRaisedButton(
            title: 'Выбрать регион',
            onPressed: () {
              _changeRegionAndCity(context);
            },
          )
        ],
      ),
    );
  }

  Widget _buildShopListIsEmpty(searchButton) {
    return Column(
      children: [
        searchButton,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const HBox(16),
              const ChangeLocationButton(),
              const HBox(56),
              Text(
                'Магазины не найдены.',
                textAlign: TextAlign.center,
                style: AppTextStyles.textAppearanceBody1.copyWith(
                  color: BristolColors.onyx,
                ),
              ),
              const HBox(16),
              Text(
                'Ближайшие магазины совсем далеко от вас,'
                ' попробуйте вернуться на карту и найти их вручную.',
                textAlign: TextAlign.center,
                style: AppTextStyles.textAppearanceBody1.copyWith(
                  color: BristolColors.onyx,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onItemSelected(
    BuildContext context, {
    required Shop shop,
  }) {
    navigatorPop(context, shop);
  }

  void _changeRegionAndCity(BuildContext context) async {
    final location = await ChangeRegionScreen.show(context);
    if (location?.region != null && location?.city != null) {
      await context.read<AppStore>().pickLocation(location!);
    }
  }
}
