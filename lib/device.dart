import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Device {
  int serialNumber;
  String deviceName;
  bool isOn;

  Device(this.serialNumber, this.deviceName, this.isOn);
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
        appBar: null,
        body: ListView.builder(
            itemCount: listOfDevices.length,
            itemBuilder: (BuildContext context, int index){
              return DeviceListItem(listOfDevices[index]);
            }),
      ),
    );
  }
}

class DeviceListItem extends StatelessWidget {
  final Device device;

  const DeviceListItem(this.device);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(device.deviceName),
          ),
          Expanded(flex: 1, child: Text(device.serialNumber.toString())),
          Expanded(flex: 1, child: Text(device.isOn ? "On" : "Off")),
        ],
      ),
    );
  }
}
