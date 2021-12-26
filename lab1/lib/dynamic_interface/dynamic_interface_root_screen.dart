import 'package:flutter/material.dart';

class DynamicInterfaceRootScreen extends StatefulWidget {
  const DynamicInterfaceRootScreen({Key? key}) : super(key: key);

  @override
  _DynamicInterfaceRootScreenState createState() =>
      _DynamicInterfaceRootScreenState();
}

class _DynamicInterfaceRootScreenState
    extends State<DynamicInterfaceRootScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dynamic'),
      ),
    );
  }
}
