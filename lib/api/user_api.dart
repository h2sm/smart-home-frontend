import 'dart:convert';

import 'package:testing/api/BaseAPI.dart';
import 'package:http/http.dart' as http;
import '../device.dart';

class UserAPI extends BaseAPI {
  static late String _apiKey;

  Future<List<Device>> getListOfDevices() async {
    List<Device> parsedObjects = <Device>[];
    var header = {"Authorization": _apiKey};
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
