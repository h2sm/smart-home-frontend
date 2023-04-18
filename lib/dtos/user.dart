class User {
  String _token;
  String _email;

  User({
    required String email,
    required String token,
  }) : _email = email, _token = token;

  String get token => _token;
  String get email => _email;
  
  factory User.fromJson() {
    return User(email: _email, token: _token)
  }
}