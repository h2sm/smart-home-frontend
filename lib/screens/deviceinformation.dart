import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/device.dart';

class DeviceInformation extends StatelessWidget {
  final Device device;

  const DeviceInformation(this.device);

  @override
  Widget build(BuildContext context) {
    var serial = device.serialNumber.toString();
    var isOn = device.isOn ? "On" : "Off";
    var deviceLocation = device.roomLocation;
    var deviceName = device.deviceName;
    return Scaffold(
      appBar: AppBar(title: const Text('Device information')),
      body: Center(
        child: Hero(
          tag: 'ListTile-Hero',
          child: Material(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 3.0),
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    deviceName,
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.w300),
                  ),
                  Text('Serial number is $serial'),
                  Text('Located in $deviceLocation'),
                  Text('Currently device is $isOn'),
                ],
              ),
            ),

            // onTap: () {
            //   Navigator.pop(context);
            // },
          ),
        ),
      ),
    );
  }
}
