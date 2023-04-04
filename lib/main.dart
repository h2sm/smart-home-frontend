import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/api/AuthAPI.dart';
import 'package:testing/bloc/login/LoginBloc.dart';
import 'package:testing/bloc/login/state/LoginState.dart';
import 'package:testing/screens/loginPage/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final ByteData data = await rootBundle.load('assets/ca/lets-encrypt-r3.pem');
  // HttpOverrides.global = CustomHttpOverrides(data);

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(authAPI: AuthAPI()),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
            return LoginView();
        },
      ),
    );
  }
}
