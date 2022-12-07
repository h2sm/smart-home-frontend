import 'package:flutter/material.dart';
import 'package:testing/main.dart';

import '../device.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<Login> {
  final _key = GlobalKey<FormState>();
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Smart Home",
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home: Scaffold(
        appBar: null,
        body: returnAllTexts(),
      ),
    );
  }

  Container returnAllTexts(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 25.0),
      alignment: Alignment.center,
      child: Form(
        key: _key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            inputHeaderText(),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: TextFormField(
                validator: (value) {
                  return validateEnteredText(value);
                },
                onSaved: (String? value) {
                  email = value.toString();
                },
                decoration: InputDecoration(
                  labelText: "Enter your email",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: TextFormField(
                validator: (value) {
                  return validateEnteredText(value);
                },
                onSaved: (String? value) {
                  password = value.toString();
                },
                decoration: InputDecoration(
                  labelText: "Enter your password",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => DeviceListPage()));
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? validateEnteredText(String? text) {
    if (text == null || text.isEmpty) {
      return 'Please enter your credentials';
    }
    return null;
  }

  TextStyle? returnTextStyle() {
    return TextStyle(fontSize: 30.0, fontWeight: FontWeight.w300);
  }

  Padding addPadding() {
    return Padding(padding: EdgeInsets.all(10));
  }

  Container inputHeaderText() {
    return Container(
      alignment: Alignment.topLeft,
      child: const Text(
        "Smart Home Application",
        style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w300),
      )
    );
  }
}
