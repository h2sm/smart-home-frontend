import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/device.dart';

class DeviceInformation extends StatelessWidget{
  final Device device;
  const DeviceInformation(this.device);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListTile Hero')),
      body: Center(
        child: Hero(
          tag: 'ListTile-Hero',
          child: Material(
            child: ListTile(
              title: Text(device.deviceName.toString()),
              subtitle: const Text('Tap here to go back'),
              tileColor: Colors.blue[700],
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }

}