import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/screens/settingsPage/add_device.dart';
import 'package:testing/screens/settingsPage/add_hub.dart';
import 'package:testing/screens/settingsPage/delete_device.dart';

import 'delete_hub.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsPageState();
  }
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          returnSettingCard("Add new Device", const NewDevice()),
          returnSettingCard("Add new Hub", const NewHub()),
          returnSettingCard("Delete device", const DeleteDevice()),
          returnSettingCard("Delete Hub", const DeleteHub()),
        ],
      ),
    );
  }

  TextStyle boldTextStyle() {
    return const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500);
  }

  Card returnSettingCard(String settingName, StatefulWidget widget) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32))),
      child: ListTile(
        leading: const FlutterLogo(size: 56.0),
        title: Text(settingName),
        trailing: const Icon(Icons.add),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute<Widget>(builder: (BuildContext context) {
            return widget;
          }));
        },
      ),
    );
  }
}
