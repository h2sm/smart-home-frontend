import 'package:flutter/material.dart';
import 'package:testing/device.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'My Devices'),
    Tab(text: 'Settings'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: myTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: null,
        bottomNavigationBar: TabBar(
          controller: _tabController,
          tabs: myTabs,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              Text("Smart Home Application", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w300)),
              Padding(padding: EdgeInsets.all(15)),
              DeviceListPage(),
            ],
          ),
        )
      ),
    );
  }
}
