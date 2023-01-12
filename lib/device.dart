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
    return ListView.builder(
        shrinkWrap: true,
        itemCount: listOfDevices.length,
        itemBuilder: (BuildContext context, int index) {
          return DeviceListItem(listOfDevices[index]);
        });
  }
}

class DeviceListItem extends StatefulWidget {
  final Device device;

  const DeviceListItem(this.device, {super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DeviceListItem(device);
  }
}

class _DeviceListItem extends State<DeviceListItem> {
  Device device;
  var borderRadius = const BorderRadius.all(Radius.circular(32));


  _DeviceListItem(this.device);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        child: ListTile(
          leading: FlutterLogo(size: 56.0),
          title: Text(device.deviceName),
          subtitle: Text(device.isOn ? "On" : "Off"),
          trailing: Icon(Icons.more_vert),
          onTap: () {
            setState(() {
              device.isOn = !device.isOn;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  "Device ${device.deviceName} is now ${device.isOn ? "on" : "off"}"),
            ));
          },
          onLongPress: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Чо блядь"),
            ));
          },
        ),
      ),
    );
  }
}
