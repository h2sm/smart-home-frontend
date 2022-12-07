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
      child: Form(
        key: _key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              validator: (value) {
                return validateEnteredText(value);
              },
              onSaved: (String? value) {
                email = value.toString();
              },
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 16)),
            TextFormField(
              validator: (value) {
                return validateEnteredText(value);
              },
              onSaved: (String? value) {
                password = value.toString();
              },
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
}
