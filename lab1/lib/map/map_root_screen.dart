import 'package:flutter/material.dart';

class MapRootScreen extends StatefulWidget {
  const MapRootScreen({Key? key}) : super(key: key);

  @override
  _MapRootScreenState createState() => _MapRootScreenState();
}

class _MapRootScreenState extends State<MapRootScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('map'),
      ),
    );
  }
}
