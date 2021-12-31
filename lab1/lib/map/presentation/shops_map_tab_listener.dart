import 'package:bristol_app/app/domain/bloc/app_store.dart';
import 'package:bristol_app/app/presentation/routing/router.dart';
import 'package:bristol_app/app/presentation/routing/tab_listener.dart';
import 'package:bristol_app/di/service_locator.dart';
import 'package:bristol_app/features/shops/domain/bloc/tabbed_shop_map_cubit.dart';

class ShopsMapTabListener implements TabListener {
  @override
  void onTabChanged(RouterTab routerTab) {
    if (routerTab == RouterTab.shopMap) {
      final isFirstPage = AppRouter.current.isFirstPage(routerTab);
      final pickedShop = locator.get<AppStore>().state.pickedShop;
      if (pickedShop != null && isFirstPage) {
        locator.get<TabbedShopMapCubit>().fetchShopMarkers(
              pickedShop: pickedShop,
            );
      }
    }
  }
}
