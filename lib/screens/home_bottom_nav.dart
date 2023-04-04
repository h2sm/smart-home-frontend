import 'package:flutter/material.dart';
import 'package:testing/screens/devicesPage/devices_list_view.dart';
import 'package:testing/screens/settingsPage/settings_page.dart';

class HomeScreen extends StatefulWidget {
  final String api;

  const HomeScreen({super.key, required this.api});

  static Route route(String apiKey) {
    return MaterialPageRoute(
      builder: (context) => HomeScreen(api: apiKey),
    );
  }

  @override
  State<StatefulWidget> createState() {
    return _HomeFormState();
  }
}

class _HomeFormState extends State<HomeScreen>{
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
