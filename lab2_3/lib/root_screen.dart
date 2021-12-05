import 'package:flutter/material.dart';
import 'package:lab2_3/result.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  double? _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          children: [
            Result(_result != null ? _result.toString() : null),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                children: [
                  _buildCell(color: Colors.black38, title: 'AC', onTap: () {}),
                  _buildCell(color: Colors.black38, title: 'x -1', onTap: () {}),
                  _buildCell(color: Colors.black38, title: '%', onTap: () {}),
                  _buildCell(color: Colors.orange, title: '/', onTap: () {}),
                  _buildCell(color: Colors.grey.withOpacity(0.6), title: '7', onTap: () {}),
                  _buildCell(color: Colors.grey.withOpacity(0.6), title: '8', onTap: () {}),
                  _buildCell(color: Colors.grey.withOpacity(0.6), title: '9', onTap: () {}),
                  _buildCell(color: Colors.orange, title: 'X', onTap: () {}),
                  _buildCell(color: Colors.grey.withOpacity(0.6), title: '4', onTap: () {}),
                  _buildCell(color: Colors.grey.withOpacity(0.6), title: '5', onTap: () {}),
                  _buildCell(color: Colors.grey.withOpacity(0.6), title: '6', onTap: () {}),
                  _buildCell(color: Colors.orange, title: '-', onTap: () {}),
                  _buildCell(color: Colors.grey.withOpacity(0.6), title: '1', onTap: () {}),
                  _buildCell(color: Colors.grey.withOpacity(0.6), title: '2', onTap: () {}),
                  _buildCell(color: Colors.grey.withOpacity(0.6), title: '3', onTap: () {}),
                  _buildCell(color: Colors.orange, title: '+', onTap: () {}),
                  _buildCell(color: Colors.grey.withOpacity(0.6), title: '0', onTap: () {}),
                  _buildCell(color: Colors.grey.withOpacity(0.6), title: ',', onTap: () {}),
                  _buildCell(color: Colors.grey.withOpacity(0.6), title: '=', onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCell({
    required Color color,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: color,
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
