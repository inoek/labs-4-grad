import 'package:flutter/material.dart';
import 'package:lab1/input_form.dart';
import 'package:lab1/input_form_vm.dart';
import 'package:lab1/storage_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const _RootScreen(),
    );
  }
}

class _RootScreen extends StatelessWidget {
  const _RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => InputFormVM(),
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
