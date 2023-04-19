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
                          child: DropdownButton<HubDTO>(
                            items: dropdownList,
                            value: snapshot.data?.first,
                            onChanged: (HubDTO? value) {
                              selectedHub = value!;
                            },
                          ))
                    ],
                  )));
            }
          }
          return const Text("peeepeee pooopooo");
        });
  }
}
