import 'package:flutter/material.dart';
import 'package:testing/device.dart';
import 'package:testing/screens/devices_list.dart';
import 'package:testing/screens/settings_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<BottomNavigationBarItem> myTabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "My devices"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
  ];

  final List<Widget> _widgetOptions = <Widget>[
    DevicesList(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: null,
          bottomNavigationBar: BottomNavigationBar(
            items: myTabs,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
          body: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
