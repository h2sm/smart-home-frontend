import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/screens/setup_new_device.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsPageState();
  }

}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          SetupDeviceView()
        ],
      ),
    );
  }

  TextStyle boldTextStyle(){
    return TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500);
  }

  Card returnSettingCard(String settingName){
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
      child: ListTile(
        leading: FlutterLogo(size: 56.0),
        title: Text(settingName),
        trailing: Icon(Icons.settings_applications),
        onTap: () {
          setState(() {
            ////
          });
        },
        onLongPress: () {
        ////
        },
      ),
    );
  }

}