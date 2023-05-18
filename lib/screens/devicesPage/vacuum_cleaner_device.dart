import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/dtos/device_dto.dart';

class VacuumCleanerInfo extends StatefulWidget {
  const VacuumCleanerInfo({super.key, required this.device});

  final Device device;

  @override
  State<StatefulWidget> createState() {
    return _VacuumCleanerInfoState();
  }
}

class _VacuumCleanerInfoState extends State<VacuumCleanerInfo> {
  @override
  Widget build(BuildContext context) {
    var device = widget.device;
    var serial = device.deviceSerial;
    var isOn = device.details["isOn"] == "true" ? "On" : "Off";
    var deviceLocation = device.deviceLocation;
    var deviceName = device.deviceName;

    TextStyle returnTextStyle() {
      return const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w200);
    }

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
                    style: const TextStyle(
                        fontSize: 30.0, fontWeight: FontWeight.w300),
                  ),
                  Text('Serial number is $serial', style: returnTextStyle()),
                  Text('Located in $deviceLocation', style: returnTextStyle()),
                  Text('Currently device is $isOn', style: returnTextStyle()),
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