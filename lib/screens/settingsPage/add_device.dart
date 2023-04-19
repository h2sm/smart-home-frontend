import 'package:flutter/material.dart';
import 'package:testing/api/AuthAPI.dart';
import 'package:testing/dtos/hub_dto.dart';
import 'package:testing/dtos/new_device_dto.dart';

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
  late HubDTO selectedHub;

  void submitData() {
    var newDevice = AddedDevice(
        deviceName: deviceName.value.text,
        deviceLocation: deviceLocation.value.text,
        deviceSerial: deviceSerial.value.text,
        deviceLocalIpAddress: deviceLocalIpAddress.value.text,
        hubUuid: selectedHub.hubUuid);

    AuthAPI.addNewDevice(newDevice);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Device added"),
      ),
    );
  }

  List<DropdownMenuItem<HubDTO>> generateDropdown(
      AsyncSnapshot<List<HubDTO>> list) {
    var dropdownItems = List.generate(
        list.data!.length,
        (index) => DropdownMenuItem<HubDTO>(
              value: list.data![index],
              child: Text(list.data![index].hubName),
            ));
    return dropdownItems;
  }

  Future<List<HubDTO>> _getListOfHubs() async {
    var futureList = AuthAPI.getListOfHubs();
    return futureList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getListOfHubs(),
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
              selectedHub = dropdownList.first.value!;
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    submitData();
                  },
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.save),
                ),
                appBar: AppBar(
                  title: const Text("Device Setup"),
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 280,
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: deviceName,
                            autocorrect: true,
                            decoration: const InputDecoration(
                                hintText: 'Enter Device name here'),
                          )),
                      Container(
                          width: 280,
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: deviceLocation,
                            autocorrect: true,
                            decoration: const InputDecoration(
                                hintText: 'Enter device location'),
                          )),
                      Container(
                          width: 280,
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: deviceSerial,
                            autocorrect: true,
                            decoration: const InputDecoration(
                                hintText: 'Enter device serial number'),
                          )),
                      Container(
                          width: 280,
                          padding: const EdgeInsets.all(10.0),
                          child: DropdownButton<HubDTO>(
                            items: dropdownList,
                            value: snapshot.data?.first,
                            onChanged: (HubDTO? value) {
                              print(value);
                            },
                          )),
                      Container(
                          width: 280,
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: deviceLocalIpAddress,
                            autocorrect: true,
                            decoration: const InputDecoration(
                                hintText: 'Enter device local IP address'),
                          )),
                    ],
                  ),
                ),
              );
            }
          }
          return Text('snapshot.data![0].value?.hubName');
        });
  }
}
