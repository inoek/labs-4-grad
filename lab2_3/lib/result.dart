import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result(this.result, {Key? key}) : super(key: key);
  final num result;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      width: double.infinity,
      color: Colors.blueGrey,
      alignment: Alignment.centerRight,
      child: Text(result.toString(), style: const TextStyle(fontSize: 24),),
    );
  }
}
