import 'package:flutter/material.dart';
import 'package:lab2_3/result.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  num _result = 0;
  String? _currentValue;

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
            Result(_result),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                children: [
                  _buildCell(
                      color: Colors.black38,
                      title: 'AC',
                      onTap: () {
                        _result = 0;
                        _currentValue = null;
                        setState(() {});
                      }),
                  _buildCell(
                      color: Colors.black38,
                      title: 'x -1',
                      onTap: () {
                        if (_currentValue != null) {
                          if (_currentValue![0] != '-') {
                            _currentValue = '-' + _currentValue!;
                          } else {
                            _currentValue =
                                _currentValue!.replaceFirst('-', '');
                          }
                          _result = int.parse(_currentValue!);
                        }
                        setState(() {});
                      }),
                  _buildCell(
                      color: Colors.black38,
                      title: '%',
                      onTap: () {
                        if (_currentValue != null) {
                          final localResult =
                              double.parse(_currentValue!) / 100;
                          _currentValue = localResult.toString();
                          _result = localResult;
                          setState(() {});
                        }
                      }),
                  _buildCell(color: Colors.orange, title: '/', onTap: () {}),
                  _buildCell(
                      color: Colors.grey.withOpacity(0.6),
                      title: '7',
                      onTap: () {
                        _setNumber(7);
                      }),
                  _buildCell(
                      color: Colors.grey.withOpacity(0.6),
                      title: '8',
                      onTap: () {
                        _setNumber(8);
                      }),
                  _buildCell(
                      color: Colors.grey.withOpacity(0.6),
                      title: '9',
                      onTap: () {
                        _setNumber(9);
                      }),
                  _buildCell(color: Colors.orange, title: 'X', onTap: () {}),
                  _buildCell(
                      color: Colors.grey.withOpacity(0.6),
                      title: '4',
                      onTap: () {
                        _setNumber(4);
                      }),
                  _buildCell(
                      color: Colors.grey.withOpacity(0.6),
                      title: '5',
                      onTap: () {
                        _setNumber(5);
                      }),
                  _buildCell(
                      color: Colors.grey.withOpacity(0.6),
                      title: '6',
                      onTap: () {
                        _setNumber(6);
                      }),
                  _buildCell(color: Colors.orange, title: '-', onTap: () {}),
                  _buildCell(
                      color: Colors.grey.withOpacity(0.6),
                      title: '1',
                      onTap: () {
                        _setNumber(1);
                      }),
                  _buildCell(
                      color: Colors.grey.withOpacity(0.6),
                      title: '2',
                      onTap: () {
                        _setNumber(2);
                      }),
                  _buildCell(
                      color: Colors.grey.withOpacity(0.6),
                      title: '3',
                      onTap: () {
                        _setNumber(3);
                      }),
                  _buildCell(color: Colors.orange, title: '+', onTap: () {}),
                  _buildCell(
                      color: Colors.grey.withOpacity(0.6),
                      title: '0',
                      onTap: () {
                        _setNumber(0);
                      }),
                  _buildCell(
                      color: Colors.grey.withOpacity(0.6),
                      title: ',',
                      onTap: () {}),
                  _buildCell(
                      color: Colors.grey.withOpacity(0.6),
                      title: '=',
                      onTap: () {}),
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

  void _setNumber(int digit) {
    if (_currentValue?.isNotEmpty != true) {
      _currentValue = digit.toString();
    } else {
      _currentValue = _currentValue! + digit.toString();
    }
    if (_currentValue != null) {
      _result = int.parse(_currentValue!);
    }
    setState(() {});
  }
}
