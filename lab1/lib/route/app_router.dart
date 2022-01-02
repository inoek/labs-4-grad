import 'package:flutter/material.dart';
import 'package:lab1/calculator/presentation/calculator_screen.dart';
import 'package:lab1/card_book/ui/card_book_root_screen.dart';
import 'package:lab1/dynamic_interface/dynamic_interface_root_screen.dart';
import 'package:lab1/map/map_root_screen.dart';

final appRouter = AppRouter();

class AppRouter {
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  final _currentTabNotifier = ValueNotifier(0);

  int get currentTab => _currentTabNotifier.value;

  Widget buildBottomNavigationBar(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _currentTabNotifier,
        builder: (context, value, child) {
          return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                _currentTabNotifier.value = index;
              },
              currentIndex: currentTab,
              items: [
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.account_box_outlined),
                  icon: Icon(Icons.account_box_outlined),
                  label: 'Lab 1, 5',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.account_box_outlined),
                  icon: Icon(Icons.account_box_outlined),
                  label: 'Lab 2, 3',
                ),
                //Rec
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.account_box_outlined),
                  icon: Icon(Icons.account_box_outlined),
                  label: 'Lab 4',
                ),
                //Profile
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.account_box_outlined),
                  icon: Icon(Icons.account_box_outlined),
                  label: 'Lab 6',
                ),
              ]);
        });
  }

  Widget buildRootBody(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: _currentTabNotifier,
        builder: (context, value, child) {
          return IndexedStack(
            index: value,
            children: [
              _buildStackItem(context, 0, const CardBookRootScreen()),
              _buildStackItem(context, 1, const CalculatorScreen()),
              _buildStackItem(context, 2, const DynamicInterfaceRootScreen()),
              _buildStackItem(context, 3, const MapRootScreen())
            ],
          );
        });
  }

  Widget _buildStackItem(BuildContext context, int index, Widget child) {
    return Offstage(
      offstage: currentTab != index,
      child: IgnorePointer(ignoring: currentTab != index, child: child),
    );
  }
}

extension AppRouterExtension on AppRouter {
  Future push(BuildContext context, Widget screen) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => screen));
  }

  Future pushModalScreen(BuildContext context, Widget screen) {
    return Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => screen, fullscreenDialog: true));
  }

  Future replace(BuildContext context, Widget screen) {
    return Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => screen));
  }

  Future pushAndPopToRoot(BuildContext context, Widget screen) {
    return Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (_) => screen), (route) => false);
  }

  void pop<T>(BuildContext context, [T? result]) {
    Navigator.of(context).maybePop(result);
  }
}
