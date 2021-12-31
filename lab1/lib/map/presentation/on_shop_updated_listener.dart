import 'package:bristol_app/app/domain/bloc/app_store.dart';
import 'package:bristol_app/app/domain/model/app_state.dart';
import 'package:bristol_app/features/shops/data/model/shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserShopUpdatedListener extends StatelessWidget {
  const UserShopUpdatedListener({
    Key? key,
    required this.onShopUpdated,
    this.child,
  }) : super(key: key);

  final Function(BuildContext context, Shop? shop) onShopUpdated;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppStore, AppState>(
      listenWhen: (last, next) => last.pickedShop != next.pickedShop,
      listener: (context, state) {
        onShopUpdated(context, state.pickedShop);
      },
      child: child,
    );
  }
}
