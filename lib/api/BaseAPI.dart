class BaseAPI {
  static String base = "http://localhost:8082";
  static var api = "$base/api";
  final _loginPath = "$api/login";

  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };

  get loginPath => _loginPath;
}
