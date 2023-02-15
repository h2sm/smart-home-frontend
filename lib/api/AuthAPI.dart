import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:testing/device.dart';
import 'BaseAPI.dart';

class AuthAPI extends BaseAPI {
  final storage = const FlutterSecureStorage();
  static late String _ApiKey;

  Future<http.Response> signUp(
      String email, String password, bool rememberMe) async {
    var body = jsonEncode({
      'user': {'email': email, 'password': password, 'rememberMe': rememberMe}
    });

    http.Response response = await http.post(super.loginPath,
        headers: super.headers, body: body); // not correct
    return response;
  }

  Future<http.Response> login(
      String email, String password, bool rememberMe) async {
    var body = jsonEncode(
        {'email': email, 'password': password, 'rememberMe': rememberMe});
    http.Response response = await http.post(
        Uri.parse("http://localhost:8082/api/auth/login"),
        headers: super.headers,
        body: body);
    var parsed = jsonDecode(response.body.toString());
    // print('${parsed.runtimeType} : $parsed');
    _ApiKey = parsed['credentials'];
    print(parsed['credentials']);
    await storage.write(key: 'token', value: 'Bearer ' + parsed['credentials']);
    return response;
  }

  Future<List<Device>> getListOfDevices() async {
    List<Device> parsedObjects = <Device>[];
    var value = await storage.read(key: 'token');
    var header = {"Authorization": value.toString()};
    await http
        .get(Uri.parse("http://localhost:8082/api/devices/list"),
            headers: header)
        .then((response) {
      Iterable l = json.decode(response.body);
      parsedObjects = List<Device>.from(l.map((dev) => Device.fromJson(dev)));
    }).onError((error, stackTrace) => Future.error(error.toString()));
    return parsedObjects;
  }
}
