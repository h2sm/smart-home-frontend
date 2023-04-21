import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nsd/nsd.dart';
import 'package:testing/dtos/hub_dto.dart';
import 'package:testing/dtos/new_device_dto.dart';
import 'package:testing/dtos/new_hub_dto.dart';
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
    var parsed = jsonDecode(response.body.toString());
    print(parsed);
    print(parsed['token']);
    apiKey = parsed['token'];
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
        });
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

  set api(String val) {
    apiKey = val;
  }

  String get api {
    return apiKey;
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

  static Future<http.Response> addNewDevice(AddedDevice device) async {
    var header = {
      "Authorization": 'Bearer $apiKey',
      "Content-Type": "application/json",
    };
    var res = await http.post(Uri.parse("$_SERVER/api/devices/new"),
        body: jsonEncode(device), headers: header);

    if (res.statusCode != 200) {
      print(res.statusCode);
    }

    return res;
  }

  static void deleteDevice(int deviceId) async {
    var header = {
      "Authorization": 'Bearer $apiKey',
      "Content-Type": "application/json",
    };

    var res = await http.delete(Uri.parse("$_SERVER/api/devices/$deviceId"),
        headers: header);
    if (res.statusCode != 200) {
      print(res.statusCode);
    }
  }

  static Future<List<HubDTO>> getListOfHubs() async {
    List<HubDTO> parsedObjects = <HubDTO>[];
    var header = {
      "Authorization": 'Bearer $apiKey',
      "Content-Type": "application/json",
    };
    var res =
        await http.get(Uri.parse("$_SERVER/api/hub/list"), headers: header);

    if (res.statusCode != 200) {
      print(res.statusCode);
    }
    Iterable l = json.decode(res.body);
    parsedObjects = List<HubDTO>.from(l.map((dev) => HubDTO.fromJson(dev)));

    return parsedObjects;
  }

  static void addHub(NewHubDTO dto) async {
    var header = {
      "Authorization": 'Bearer $apiKey',
      "Content-Type": "application/json",
    };
    var res = await http.post(Uri.parse("$_SERVER/api/hub"),
        headers: header, body: json.encode(dto));
  }

  static void deleteHub(String uuid) async {
    var header = {
      "Authorization": 'Bearer $apiKey',
      "Content-Type": "application/json",
    };
    var res =
        await http.delete(Uri.parse("$_SERVER/api/hub/$uuid"), headers: header);
    if (res.statusCode != 200) {
      throw Exception();
    }
  }
}
