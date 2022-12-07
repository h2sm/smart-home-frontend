import 'package:flutter/material.dart';

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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
      alignment: AlignmentDirectional.topCenter,
      child: Form(
        key: _key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Login",
              style: returnTextStyle(),
            ),
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
            Text(
              "Password",
              style: returnTextStyle(),
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
            )
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
}
