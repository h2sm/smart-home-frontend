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
  late Future<List<HubDTO>> future;
  late HubDTO selectedHub;

  @override
  void initState() {
    future = AuthAPI.getListOfHubs();
    future.then((value) => {
      listOfHubs = value,
      selectedHub = value.first,
    });
    super.initState();
  }

  void submitData() {
    try {
      AuthAPI.deleteHub(selectedHub.hubUuid);
    } on Exception catch (e) {
      print(e.runtimeType);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HubDTO>>(
        future: future,
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
                  child: DropdownButton<HubDTO>(
                    items: snapshot.data?.map((item) {
                      return DropdownMenuItem<HubDTO>(
                          value: item, child: Text(item.hubName));
                    }).toList(),
                    value: selectedHub,
                    hint: const Text('Select a hub'),
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
                setState(() {
                  submitData();
                });
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
