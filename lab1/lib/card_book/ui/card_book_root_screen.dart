import 'package:flutter/material.dart';
import 'package:lab1/card_book/domain/input_form_vm.dart';
import 'package:lab1/card_book/domain/models.dart';
import 'package:lab1/card_book/ui/storage_view.dart';
import 'package:provider/provider.dart';

import 'input_form.dart';

class CardBookRootScreen extends StatelessWidget {
  const CardBookRootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => InputFormVM(),
        ),
        ChangeNotifierProvider(
          create: (_) => Student(),
        ),
        ChangeNotifierProvider(
          create: (_) => Teacher(),
        ),
      ],
      child: Consumer<InputFormVM>(
        builder: (BuildContext context, vm, _) {
          return Navigator(
            pages: [
              MaterialPage(
                child: InputForm(),
              ),
              if (vm.isEmpty == false)
                MaterialPage(
                  child: StorageView(),
                ),
            ],
            onPopPage: (route, result) {
              return route.didPop(result);
            },
          );
        },
      ),
    );
  }
}
