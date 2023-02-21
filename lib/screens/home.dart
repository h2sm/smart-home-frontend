import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/api/AuthAPI.dart';
import 'package:testing/bloc/content/content_bloc.dart';
import 'package:testing/bloc/content/state/content_state.dart';
import 'package:testing/screens/devices_list.dart';
import 'package:testing/screens/settings_page.dart';

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
    return _HomeFormState(api);
  }
}

// class _HomeScreenState extends State<HomeScreen> {
//   late final String _api;
//
//   @override
//   void initState() {
//     super.initState();
//     _api = widget.api;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ContentBloc(authAPI: _api),
//       child: BlocBuilder<ContentBloc, ContentState>(
//         builder: (context, state) {
//           return HomeView();
//         },
//       ),
//     );
//   }
// }
//
// class HomeView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<ContentBloc, ContentState>(
//         listener: (context, state) {
//           if (state is ContendDownloadSuccess){
//               HomeForm();
//           }
//
//           else {
//             //еще другое
//           }
//         });
//   }
// }

// class HomeForm extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _HomeFormState();
//   }
// }

class _HomeFormState extends State<HomeScreen>{

  final String apiKey;

  int _selectedIndex = 0;
  final List<BottomNavigationBarItem> myTabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "My devices"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
  ];

  final List<Widget> _widgetOptions = <Widget>[
    DevicesList(),
    SettingsPage(),
  ];

  _HomeFormState(this.apiKey);

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
