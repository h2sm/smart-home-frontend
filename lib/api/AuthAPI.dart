import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:testing/device.dart';
import 'BaseAPI.dart';

class AuthAPI extends BaseAPI {
  final storage = const FlutterSecureStorage();
  static late String apiKey;

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
    print(parsed['credentials']);
    apiKey = parsed['credentials'];
    return response;
  }

  static Future<List<Device>> getListOfDevices() async {
    List<Device> parsedObjects = <Device>[];
    var header = {
      "Authorization": 'Bearer ' + apiKey,
      "Content-Type": "application/json",
    };
    print(header);
    try {
      var res = await http.get(
          Uri.parse("http://localhost:8082/api/devices/list"),
          headers: header);
      print(res.body.toString());
      Iterable l = json.decode(res.body);
      parsedObjects = List<Device>.from(l.map((dev) => Device.fromJson(dev)));
    } catch (e) {
      print(e.toString());
    }

    return parsedObjects;
  }

  // set apiKey(String val) => apiKey = val;
  void set api(String val) {
    apiKey = val;
  }

  static Future switchStateOfDevice(int deviceID, bool isOn) async {
    var header = {
      "Authorization": 'Bearer ' + apiKey,
      "Content-Type": "application/json",
    };
    print("{$deviceID} device id");
    var res = await http.put(
        Uri.parse("http://localhost:8082/api/devices/$deviceID/state"),
        body: jsonEncode(isOn),
        headers: header);
    if (res.statusCode != 200) {
      print(res.statusCode);
      throw Exception("Cannot switch state to {$isOn}");
    }

    return null;
  }
}
