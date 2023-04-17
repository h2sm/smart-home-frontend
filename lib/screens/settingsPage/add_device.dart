import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewDevice extends StatefulWidget {
  const NewDevice({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewDeviceState();
  }
}

class _NewDeviceState extends State<NewDevice> {
  final deviceName = TextEditingController();
  final deviceLocation = TextEditingController();
  final deviceSerial = TextEditingController();
  final deviceLocalIpAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Device Setup"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 280,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: deviceName,
                  autocorrect: true,
                  decoration:
                      InputDecoration(hintText: 'Enter Device name here'),
                )),
            Container(
                width: 280,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: deviceLocation,
                  autocorrect: true,
                  decoration:
                      InputDecoration(hintText: 'Enter device location'),
                )),
            Container(
                width: 280,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: deviceSerial,
                  autocorrect: true,
                  decoration:
                      InputDecoration(hintText: 'Enter device serial number'),
                )),
            Container(
                width: 280,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: deviceLocalIpAddress,
                  autocorrect: true,
                  decoration: InputDecoration(
                      hintText: 'Enter device local IP address'),
                )),
          ],
        ),
      ),
    );
  }
}
