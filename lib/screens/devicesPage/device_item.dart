import 'package:flutter/material.dart';
import 'package:testing/api/AuthAPI.dart';
import 'package:testing/screens/devicesPage/device_information.dart';

import '../../dtos/device_dto.dart';

class DeviceListPage extends StatefulWidget {
  const DeviceListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DeviceListPageState();
  }
}

class _DeviceListPageState extends State<DeviceListPage> {
  Future<List<Device>> _getListOfDevices() async {
    return Future.delayed(Duration(seconds: 2), () {
      print(AuthAPI.apiKey);
      return AuthAPI.getListOfDevices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<List<Device>> projectSnap) {
        if (projectSnap.connectionState == ConnectionState.waiting) {
          print(projectSnap.connectionState.toString());
          print('waiting .....');
          return const Center(child: CircularProgressIndicator());
        } else if (projectSnap.connectionState == ConnectionState.done) {
          print(projectSnap.data);
          if (!projectSnap.hasData) {
            return const Text("No data received");
          } else {
            return ListView.builder(
              itemCount: projectSnap.data?.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return DeviceListItem(projectSnap.data![index]);
              },
            );
          }
        } else {
          return Text("data");
        }
      },
      future: _getListOfDevices(),
    );
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
    var isOn = device.details["isOn"] == "true";
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        child: ListTile(
          leading: FlutterLogo(size: 56.0),
          title: Text(device.deviceName),
          subtitle: Text(isOn ? "On" : "Off"),
          trailing: Icon(Icons.more_vert),
          onTap: () {
            try {
              AuthAPI.switchStateOfDevice(device.deviceId, isOn);
              setState(() {
                isOn = !isOn;
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Device ${device.deviceName} is now ${isOn ? "on" : "off"}"),
              ));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text("Couldnt switch state of device ${device.deviceName}"),
              ));
            }
          },
          onLongPress: () {
            Navigator.push(context,
                MaterialPageRoute<Widget>(builder: (BuildContext context) {
              switch (device.type) {
                case "BULB": return DeviceInfo(device: device, type: device.type);

                case "VACUUM_CLEANER":
                  {}
              }
              return Text("d");
            }));
          },
        ),
      ),
    );
  }
}