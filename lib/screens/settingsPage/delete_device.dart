import 'package:flutter/material.dart';
import 'package:testing/api/AuthAPI.dart';

import '../../dtos/device_dto.dart';

class DeleteDevice extends StatefulWidget {
  const DeleteDevice({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DeleteDeviceState();
  }
}

class _DeleteDeviceState extends State<DeleteDevice> {
  late Future<List<Device>> futureListOfDevices;
  late List<Device> listOfDevices = [];
  late Device selectedDevice;

  Future<List<Device>> _getDevicesList() async {
    return AuthAPI.getListOfDevices();
  }

  @override
  void initState() {
    super.initState();
    AuthAPI.getListOfDevices().then((value) {
      listOfDevices = value;
      selectedDevice = value.first;
    });
  }


  void submitData() {
    AuthAPI.deleteDevice(selectedDevice.deviceId);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Device deleted"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getDevicesList(),
        builder: (context, snapshot) {
          List<Widget> children = [];
          if (!snapshot.hasData) {
            children = <Widget>[
              const Center(
                child: CircularProgressIndicator(),
              ),
            ];
          }
          if (snapshot.hasData) {
            children = <Widget>[
              Container(
                width: 280,
                padding: const EdgeInsets.all(10.0),
                child: DropdownButton<Device>(
                  items: listOfDevices.map((item) {
                    return DropdownMenuItem<Device>(
                        value: item, child: Text(item.deviceName));
                  }).toList(),
                  value: selectedDevice,
                  onChanged: (device) async {
                    setState(() {
                      selectedDevice = device!;
                    });
                  },
                ),
              )
            ];
          }
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              child: const Icon(Icons.delete),
              onPressed: () {
                submitData();
              },
            ),
            appBar: AppBar(
              title: const Text("Delete device"),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            ),
          );
        });
  }
}
