import 'package:flutter/material.dart';

class DynamicInterfaceRootScreen extends StatefulWidget {
  const DynamicInterfaceRootScreen({Key? key}) : super(key: key);

  @override
  _DynamicInterfaceRootScreenState createState() =>
      _DynamicInterfaceRootScreenState();
}

class _DynamicInterfaceRootScreenState
    extends State<DynamicInterfaceRootScreen> {
  List<Widget> _genList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dynamic widgets'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          _buildTitleButton(),
          const SizedBox(height: 30),
          ..._genList.map((e) => e),
        ],
      ),
    );
  }

  Widget _buildTitleButton() {
    return _genList.isNotEmpty != true
        ? TextButton(
            onPressed: () {
              setState(
                () {
                  _genList.addAll(
                    List.generate(
                      10,
                      (index) => Text(
                        index.toString(),
                      ),
                    ),
                  );
                },
              );
            },
            child: Text('Generate widgets'))
        : TextButton(
            onPressed: () {
              setState(
                () {
                  _genList = [];
                },
              );
            },
            child: Text('Kill widgets'));
  }
}
