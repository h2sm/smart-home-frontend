import 'package:flutter/material.dart';
import 'package:testing/device.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const DeviceListPage(),
    );
  }
}

class DeviceListPage extends StatefulWidget {
  const DeviceListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DeviceListPageState();
  }
}

class _DeviceListPageState extends State<DeviceListPage> {
  List<Device> listOfDevices = [
    Device(1111, "Lampa", true),
    Device(2222, "Holodilnik", false),
    Device(222222, "Holodi2lnik", true),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Smart Home",
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home: Scaffold(
        appBar: AppBar(title: Text("Test Smart Home")),
        body: ListView.builder(
          itemCount: listOfDevices.length,
          itemBuilder: (BuildContext context, int index) {
            return DeviceListItem(listOfDevices[index]);
          },
        ),
      ),
    );
  }
}