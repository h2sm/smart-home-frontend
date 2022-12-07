import 'dart:convert';
import 'package:http/http.dart' as http;
import 'BaseAPI.dart';

class AuthAPI extends BaseAPI {
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

    http.Response response =
        await http.post(super.loginPath, headers: super.headers, body: body);

    return response;
  }

// Future<http.Response> logout(int id, String token) async {
//   var body = jsonEncode({'id': id, 'token': token});
//
//   http.Response response =
//       await http.post(super.logoutPath, headers: super.headers, body: body);
//
//   return response;
// }
}
