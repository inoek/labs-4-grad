import 'package:flutter/material.dart';
import 'package:lab1/route/app_router.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: appRouter.buildRootBody(context),
      bottomNavigationBar: appRouter.buildBottomNavigationBar(context),
    );
  }
}
