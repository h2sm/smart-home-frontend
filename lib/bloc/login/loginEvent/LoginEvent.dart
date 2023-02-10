import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent([List props = const []]);
}

class LoginRequested extends LoginEvent {
  const LoginRequested() : super();

  @override
  List<Object> get props => [];
}

class LoginButtonPressedEvent extends LoginEvent {
  const LoginButtonPressedEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoginEmailChangedEvent extends LoginEvent {
  const LoginEmailChangedEvent({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class LoginPasswordChangedEvent extends LoginEvent {
  const LoginPasswordChangedEvent({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}
