import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/api/AuthAPI.dart';
import 'package:testing/screens/deviceinformation.dart';

class Device {
  final int id;
  final String deviceName;
  final String deviceLocation;
  final int deviceSerial;
  final String localIpAddress;
  bool isOn = true;

  Device({
    required this.id,
    required this.deviceName,
    required this.deviceLocation,
    required this.deviceSerial,
    required this.localIpAddress,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['deviceId'],
      deviceName: json['deviceName'],
      deviceLocation: json['deviceLocation'],
      localIpAddress: json['localDeviceIp'],
      deviceSerial: json['deviceSerial'],
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
  late List _listOfDevices;
  _getListOfDevices() async {
  //   var auth = AuthAPI();
  //   _listOfDevices = await auth.getListOfDevices();
  //   print('cho');
  //   print(_listOfDevices);
  //   return auth.getListOfDevices();
  }

  @override
  Widget build(BuildContext context) {
    //return BlocProvider(create: create)
    return FutureBuilder(builder: (context, projectSnap) {
      if (!projectSnap.hasData) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return ListView.builder(
          itemCount: _listOfDevices.length,
          itemBuilder: (context, index) {
            return DeviceListItem(_listOfDevices[index]);
          },
        );
      }
    },
      future: _getListOfDevices(),
    );
  }

//   return ListView.builder(
//       shrinkWrap: true,
//       itemCount: listOfDevices.length,
//       itemBuilder: (BuildContext context, int index) {
//         return DeviceListItem(listOfDevices[index]);
//       });
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
                  "Device ${device.deviceName} is now ${device.isOn
                      ? "on"
                      : "off"}"),
            ));
          },
          onLongPress: () {
            Navigator.push(context,
                MaterialPageRoute<Widget>(builder: (BuildContext context) {
                  return DeviceInformation(device);
                }));
          },
        ),
      ),
    );
  }
}
