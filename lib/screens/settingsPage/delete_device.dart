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
  late Device selectedDevice;
  Future<List<Device>> _getDevicesList() async {
    return AuthAPI.getListOfDevices();
  }

  List<DropdownMenuItem<Device>> generateDropdown(AsyncSnapshot<List<Device>> list) {
    return List.generate(
        list.data!.length,
        (index) => DropdownMenuItem<Device>(
              value: list.data![index],
              child: Text(list.data![index].deviceName),
            ));
  }

  void submitData(){
    AuthAPI.deleteDevice(selectedDevice.id);
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var dropdownList = generateDropdown(snapshot);
              selectedDevice = dropdownList.first.value!;
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    submitData();
                  },
                ),
                appBar: AppBar(
                  title: const Text('Delete device'),
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<Device>(
                        items: dropdownList,
                        value: snapshot.data?.first,
                        onChanged: (Device? device) {
                          selectedDevice = device!;
                        },
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Scaffold();
            }
          }
          return Text('Something went wrong, idk :/');
        });
  }
}
