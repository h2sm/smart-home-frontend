import 'package:flutter/material.dart';
import 'package:testing/api/AuthAPI.dart';
import 'package:testing/dtos/hub_dto.dart';
import 'package:testing/dtos/new_device_dto.dart';

class NewDevice extends StatefulWidget {
  NewDevice({super.key});

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
  late Future<List<HubDTO>> futureListOfHubs;
  late List<HubDTO> listOfHubs = [];
  late HubDTO selectedHub;
  late List<String> listOfDeviceTypes = [];
  late String selectedType;

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

  @override
  void initState() {
    AuthAPI.getListOfHubs().then((value) {
      listOfHubs = value;
      selectedHub = value.first;
    });
    AuthAPI.getDeviceTypes().then((value) {
      listOfDeviceTypes = value;
      selectedType= value.first;
    });
    super.initState();
  }

  Future<List<HubDTO>> _getListOfHubs() async {
    var futureList = AuthAPI.getListOfHubs();
    return futureList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HubDTO>>(
        future: _getListOfHubs(),
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
                  child: DropdownButton<String>(
                    hint: const Text("Select device type"),
                    items: listOfDeviceTypes.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    value: selectedType,
                    onChanged: (newValue) async {
                      setState(() {
                      selectedType = newValue!;
                       });
                    },
                  )),
              Container(
                  width: 280,
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButton<HubDTO>(
                    hint: const Text("Select hub"),
                    items: listOfHubs.map((item) {
                      return DropdownMenuItem<HubDTO>(
                        value: item,
                        child: Text(item.hubName),
                      );
                    }).toList(),
                    value: selectedHub,
                    onChanged: (newValue) async {
                      setState(() {
                        selectedHub = newValue!;
                      });
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
            ];
          }
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              child: const Icon(Icons.save),
              onPressed: () {
                submitData();
              },
            ),
            appBar: AppBar(
              title: Text("Add device"),
            ),
            body: Center(
              child: Column(
                children: children,
              ),
            ),
          );
        });
  }
}