import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'device_item.dart';

class DevicesList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _DevicesListState();
  }
}

class _DevicesListState extends State<DevicesList> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          Text("Smart Home Application", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w300)),
          Padding(padding: EdgeInsets.all(15)),
          DeviceListPage(),
        ],
      ),
    );
  }

}