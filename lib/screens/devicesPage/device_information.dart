import 'package:flutter/material.dart';
import 'package:testing/api/AuthAPI.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../dtos/device_dto.dart';

const List<Color> colors = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.amberAccent,
  Colors.limeAccent,
  Colors.black,
];

class DeviceInfo extends StatefulWidget {
  const DeviceInfo({required this.device, required this.type});

  final Device device;
  final String type;

  @override
  State<StatefulWidget> createState() {
    return _DeviceInfoState();
  }
}

class _DeviceInfoState extends State<DeviceInfo> {
  @override
  Widget build(BuildContext context) {
    var device = widget.device;
    var type = widget.type;
    var serial = device.deviceSerial;
    var isOn = device.details["isOn"] == "true" ? "On" : "Off";
    var deviceLocation = device.deviceLocation;
    var deviceName = device.deviceName;
    Color pickerColor = Color.fromRGBO(int.parse(device.details["r"]!),
        int.parse(device.details["g"]!), int.parse(device.details["b"]!), 1.0);

    Color currentColor = Colors.amber;
    List<Color> currentColors = [Colors.yellow, Colors.green];

    void changeColor(Color color) {
      setState(() {
        currentColor = color;
        AuthAPI.changeColorOnDevice(device.deviceId, color);
      });
    }

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
                  BlockPicker(
                    pickerColor: pickerColor,
                    onColorChanged: changeColor,
                    availableColors: colors,
                  )
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
