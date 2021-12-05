import 'package:flutter/material.dart';

abstract class AppCard<T> extends StatelessWidget {
  const AppCard({Key? key}) : super(key: key);

  String get cardTitle;

  Widget get card;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cardTitle,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            card,
          ],
        ),
      ),
    );
  }
}
