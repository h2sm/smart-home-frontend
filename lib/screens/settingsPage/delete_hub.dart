import 'package:flutter/material.dart';

import '../../api/AuthAPI.dart';
import '../../dtos/hub_dto.dart';

class DeleteHub extends StatefulWidget {
  const DeleteHub({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DeleteHubState();
  }
}

class _DeleteHubState extends State<DeleteHub> {
  late List<HubDTO> listOfHubs = [];
  late HubDTO selectedHub;

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

  @override
  void initState() {
    super.initState();
    AuthAPI.getListOfHubs().then((value) {
      listOfHubs = value;
      selectedHub = value.first;
    });
  }

  Future<List<HubDTO>> _getListOfHubs() async {
    var futureList = AuthAPI.getListOfHubs();
    return futureList;
  }

  void submitData() {
    AuthAPI.deleteHub(selectedHub.hubUuid);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
            children = <Widget>[];
            children = <Widget>[
              Container(
                  width: 280,
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButton<HubDTO>(
                    items: listOfHubs.map((item) {
                      return DropdownMenuItem<HubDTO>(
                          value: item, child: Text(item.hubName));
                    }).toList(),
                    value: selectedHub,
                    onChanged: (newValue) async {
                      setState(() {
                        selectedHub = newValue!;
                      });
                    },
                  ))
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
              title: const Text("Delete hub"),
            ),
            body: Center(
              child: Column(children: children),
            ),
          );
        });
  }
}
