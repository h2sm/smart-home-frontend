import 'package:flutter/material.dart';
import 'package:testing/api/AuthAPI.dart';

import '../../dtos/new_hub_dto.dart';

class NewHub extends StatefulWidget {
  const NewHub({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewHubState();
  }
}

class _NewHubState extends State<NewHub> {
  final hubUuid = TextEditingController();
  final hubName = TextEditingController();
  final hubSecret = TextEditingController();

  void submitData() {
    var newHub = NewHubDTO(
        hubUuid: hubUuid.value.text,
        hubName: hubName.value.text,
        hubSecret: hubSecret.value.text);

    AuthAPI.addHub(newHub);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          submitData();
        },
      ),
      appBar: AppBar(
        title: const Text("Add new hub"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 280,
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: hubName,
                  decoration:
                      const InputDecoration(hintText: 'Enter Hub name here'),
                )),
            Container(
                width: 280,
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: hubUuid,
                  decoration:
                      const InputDecoration(hintText: 'Enter Hub UUID here'),
                )),
            Container(
                width: 280,
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: hubSecret,
                  decoration:
                      const InputDecoration(hintText: 'Enter Hub Secret here'),
                )),
          ],
        ),
      ),
    );
  }
}
