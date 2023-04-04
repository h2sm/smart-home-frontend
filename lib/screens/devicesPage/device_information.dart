import 'package:flutter/cupertino.dart';
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
  Colors.limeAccent
];

class DeviceInfo extends StatefulWidget {
  const DeviceInfo({required this.device});

  final Device device;

  @override
  State<StatefulWidget> createState() {
    return _DeviceInfoState();
  }
}

class _DeviceInfoState extends State<DeviceInfo> {
  @override
  Widget build(BuildContext context) {
    var device = widget.device;
    var serial = device.deviceSerial;
    var isOn = device.isOn ? "On" : "Off";
    var deviceLocation = device.deviceLocation;
    var deviceName = device.deviceName;
    var brgb = device.brgbValues;
    Color pickerColor = Color.fromRGBO(brgb.indexOf(1), brgb.indexOf(2), brgb.indexOf(3), 1.0);

    Color currentColor = Colors.amber;
    List<Color> currentColors = [Colors.yellow, Colors.green];

    void changeColor(Color color) {
      setState(() {
        currentColor = color;
        AuthAPI.changeColorOnDevice(device.id, color);
      });
    }

    TextStyle returnTextStyle() {
      return TextStyle(fontSize: 20.0, fontWeight: FontWeight.w200);
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
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.w300),
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