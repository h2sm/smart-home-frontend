import 'package:flutter/material.dart';
import 'package:testing/api/AuthAPI.dart';
import 'package:testing/screens/devicesPage/device_information.dart';
import 'package:testing/screens/devicesPage/vacuum_cleaner_device.dart';
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
    return AuthAPI.getListOfDevices();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getListOfDevices(),
      builder: (context, projectSnap) {
        List<Widget> children = [];
        if (!projectSnap.hasData) {
          children = <Widget>[const Center(child: CircularProgressIndicator())];
        }
        if (projectSnap.hasData) {
          children = <Widget>[
            ListView.builder(
              itemCount: projectSnap.data?.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return DeviceListItem(projectSnap.data![index]);
              },
            )
          ];
        }
        return Column(
          children: children,
        );
      },
    );
  }
}

class DeviceListItem extends StatefulWidget {
  final Device device;

  const DeviceListItem(this.device, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _DeviceListItemState();
  }
}

class _DeviceListItemState extends State<DeviceListItem> {
  var borderRadius = const BorderRadius.all(Radius.circular(32));

  @override
  Widget build(BuildContext context) {
    var device = widget.device;
    var isOn = device.details["isOn"] == "true";
    var isOnString = isOn ? "On" : "Off";

    Icon returnLeadingIcon(String type) {
      Icon icon = const Icon(Icons.device_unknown);
      switch (type) {
        case "BULB":
          icon = const Icon(
            Icons.lightbulb,
            size: 40.0,
          );
          break;
        case "VACUUM_CLEANER":
          icon = const Icon(
            Icons.cleaning_services,
            size: 40.0,
          );
          break;
        case "CAMERA":
          icon = const Icon(
            Icons.photo_camera_outlined,
            size: 40.0,
          );
          break;
      }
      return icon;
    }

    Widget openDevicePage(Device device) {
      late Widget widget;
      switch (device.type) {
        case "BULB": {
          widget =  DeviceInfo(device: device, type: device.type);
          break;
        }
        case "VACUUM_CLEANER": {
          widget =  VacuumCleanerInfo(device: device);
        }
      }
      return widget;
    }

    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        child: ListTile(
          leading: returnLeadingIcon(device.type),
          title: Text(device.deviceName),
          subtitle: Text(isOnString),
          trailing: const Icon(Icons.more_vert),
          onTap: () {
            AuthAPI.switchStateOfDevice(device.deviceId, !isOn);
            setState(() {
              widget.device.details["isOn"] = (!isOn).toString();
              isOn = !isOn;
              isOnString;
            });
          },
          onLongPress: () {
            Navigator.push(context,
                MaterialPageRoute<Widget>(builder: (BuildContext context) {
              return openDevicePage(device);
            }));
          },
        ),
      ),
    );
  }
}
