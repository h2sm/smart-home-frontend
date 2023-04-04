import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nsd/nsd.dart';
import '../dtos/device_dto.dart';
import 'BaseAPI.dart';

class AuthAPI extends BaseAPI {
  static late String apiKey;
  static const bool _useLocal = true;
  static const String _SERVER =
      _useLocal ? "http://127.0.0.1:8082" : "https://www.smarthome-controls.ru";

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
        Uri.parse("$_SERVER/api/auth/login"),
        headers: super.headers,
        body: body);
    print(response.body.toString());
    var parsed = jsonDecode(response.body.toString());
    print(parsed['credentials']);
    apiKey = parsed['credentials'];
    //test();
    return response;
  }

  Future<void> test() async {
    final discovery =
        await startDiscovery('_ewelink._tcp', ipLookupType: IpLookupType.v4);

    discovery.addServiceListener((service, status) {
      if (status == ServiceStatus.found) {
        discovery.services.forEach((element) {
          var add = element.addresses;
          add!.forEach((element) {
            print(element.address);
          });
          // var map = element.txt;
          // map?.forEach((key, value) {
          // String s = new String.fromCharCodes(value!);
          // print(key + ' ' + s);
          // });
        });
        // put service in own collection, etc.
      }
    });
  }

  static Future<void> changeColorOnDevice(int deviceID, Color color) async {
    var header = {
      "Authorization": 'Bearer ' + apiKey,
      "Content-Type": "application/json",
    };

    var body = {
      "brightness": 100,
      "red": color.red,
      "green": color.green,
      "blue": color.blue,
    };

    print("{$body}");
    var res = await http.put(Uri.parse("$_SERVER/api/devices/$deviceID/color"),
        body: jsonEncode(body), headers: header);
    if (res.statusCode != 200) {
      print(res.statusCode);
      // throw Exception("Cannot switch state to {$isOn}");
    }

    return;
  }

  static Future<List<Device>> getListOfDevices() async {
    List<Device> parsedObjects = <Device>[];
    var header = {
      "Authorization": 'Bearer ' + apiKey,
      "Content-Type": "application/json",
    };
    print(header);
    try {
      var res = await http.get(Uri.parse("$_SERVER/api/devices/list"),
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
    var res = await http.put(Uri.parse("$_SERVER/api/devices/$deviceID/state"),
        body: jsonEncode(isOn), headers: header);
    if (res.statusCode != 200) {
      print(res.statusCode);
      throw Exception("Cannot switch state to {$isOn}");
    }

    return null;
  }
}
