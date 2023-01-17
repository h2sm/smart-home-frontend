import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          Text("Settings", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w300)),
          Padding(padding: EdgeInsets.all(15)),
          returnSettingCard("Add new device"),
          returnSettingCard("Delete device"),
          returnSettingCard("Change password"),
          returnSettingCard("Delete Account"),
          returnSettingCard("Log off")
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