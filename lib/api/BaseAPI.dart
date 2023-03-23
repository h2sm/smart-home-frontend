class BaseAPI {
  static String base = "https://localhost:8082";
  static var api = "$base/api";
  final _loginPath = "$api/auth/login";

  Map<String, String> headers = {
    "Content-Type": "application/json"
  };

  get loginPath => _loginPath;
}
