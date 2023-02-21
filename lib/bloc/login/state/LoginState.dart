import 'package:equatable/equatable.dart';

enum LoginStatus {
  success,
  failure,
  loading,
}

class LoginState extends Equatable {
  const LoginState({
    this.message = '',
    this.status = LoginStatus.loading,
    this.email = '',
    this.password = '',
    this.apiKey = '',
  });

  final String message;
  final LoginStatus status;
  final String email;
  final String password;
  final String apiKey;

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    String? message,
    String? apiKey,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      message: message ?? this.message,
      apiKey: apiKey ?? this.apiKey,
    );
  }

  @override
  List<Object?> get props => [
    message,
    status,
    email,
    password,
  ];
}
class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {}
