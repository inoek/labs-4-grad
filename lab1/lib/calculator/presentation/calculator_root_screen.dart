import 'package:flutter/material.dart';

class CalculatorRootScreen extends StatefulWidget {
  const CalculatorRootScreen({Key? key}) : super(key: key);

  @override
  _CalculatorRootScreenState createState() => _CalculatorRootScreenState();
}

class _CalculatorRootScreenState extends State<CalculatorRootScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('calculator'),
      ),
    );
  }
}
