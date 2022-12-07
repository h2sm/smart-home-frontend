import 'package:flutter/cupertino.dart';

class Device {
  int serialNumber;
  String deviceName;
  bool isOn;

  Device(this.serialNumber, this.deviceName, this.isOn);
}

class DeviceListItem extends StatelessWidget {
  final Device device;

  const DeviceListItem(this.device);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(device.deviceName),
          ),
          Expanded(
              flex: 1,
              child: Text(device.serialNumber.toString())),
          Expanded(
              flex: 1,
              child: Text(device.isOn ? "On" : "Off")
          ),
        ],
      ),
    );
  }
}
