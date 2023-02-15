import 'package:bloc/bloc.dart';
import 'package:testing/api/AuthAPI.dart';
import 'package:testing/bloc/login/loginEvent/LoginEvent.dart';
import 'package:testing/bloc/login/state/LoginState.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthAPI authAPI,
  })  : _api = authAPI,
        super(LoginState()) {
    on<LoginButtonPressedEvent>(_handleLoginWithEmailAndPasswordEvent);
    on<LoginEmailChangedEvent>(_handleLoginEmailChangedEvent);
    on<LoginPasswordChangedEvent>(_handleLoginPasswordChangedEvent);
  }

  final AuthAPI _api;

  // @override
  // Stream<LoginState> mapEventToState(LoginEvent event) async* {
  //   if (event is LoginRequested) {
  //     yield* _newLoginRequested(event);
  //   }
  //   // if (event is WeatherCurrentPositionRequested) {
  //   //   yield* _newWeatherCurrentPositionRequested();
  //   // }
  // }

  Stream<LoginState> _newLoginRequested(LoginRequested event) async* {
    yield LoginInProgress();
    try {} catch (error) {
      yield LoginFailure();
    }
  }

  Future<void> _handleLoginEmailChangedEvent(
    LoginEmailChangedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(email: event.email));
  }

  Future<void> _handleLoginPasswordChangedEvent(
    LoginPasswordChangedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _handleLoginWithEmailAndPasswordEvent(
    LoginButtonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      var res = await _api.login(state.email, state.password, true);
      print(res.body.toString());
      emit(state.copyWith(message: 'Success', status: LoginStatus.success));
    } catch (e) {
      emit(state.copyWith(message: e.toString(), status: LoginStatus.failure));
    }
  }
}
