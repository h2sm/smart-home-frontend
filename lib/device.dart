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
            itemBuilder: (BuildContext context, int index) {
              return DeviceListItem(listOfDevices[index]);
            }),
      ),
    );
  }
}

class DeviceListItem extends StatefulWidget {
  final Device device;

  const DeviceListItem(this.device);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DeviceListItem(device);
  }
}
class _DeviceListItem extends State<DeviceListItem> {

  Device device;
  _DeviceListItem(this.device);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: SizedBox(
            width: 300,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(device.deviceName),
                Text(device.serialNumber.toString()),
                Text(device.isOn ? "On" : "Off"),
                InkWell(
                  onTap: () {
                    setState(() {
                      device.isOn = !device.isOn;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Device ${device.deviceName} is now ${device.isOn ? "on" : "off"}"),
                    ));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Flat Button'),
                  ),
                )
              ],
            )),
      ),
    );
  }

}
