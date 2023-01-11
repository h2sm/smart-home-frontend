import 'package:flutter/material.dart';
import 'package:testing/device.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: null,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              Text("Smart Home Application", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w300)),
              DeviceListPage(),
            ],
          ),
        )
      ),
    );
  }
}
