import 'package:bloc/bloc.dart';
import 'package:testing/api/AuthAPI.dart';
import 'package:testing/bloc/content/event/content_event.dart';
import 'package:testing/bloc/content/state/content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState>{
  final AuthAPI _api;
  ContentBloc({required AuthAPI authAPI}) : _api = authAPI, super(ContentState()){
    on<ContentRequested>(_handleContentRequest);
    on<ContentObtained>(_handleObtainedRequest);
    on<ContentRequestFailed>(_handleFailedRequest);

  }

  Future<void> _handleContentRequest(
      ContentRequested event,
      Emitter<ContentState> emit,
      ) async {
    var deviceList = _api.getListOfDevices();
    emit(state.copyWith(listOfDevice: event.listOfDevices));
  }

  Future<void> _handleObtainedRequest(
      ContentObtained event,
      Emitter<ContentState> emit,
      ) async {
    //emit(state.copyWith(password: event.password));
  }

  Future<void> _handleFailedRequest(
      ContentRequestFailed event,
      Emitter<ContentState> emit,
      ) async {
   // try {
    //   var res = await _api.login(state.email, state.password, true);
    //   print(res.body.toString());
    //   emit(state.copyWith(message: 'Success', status: LoginStatus.success));
    // } catch (e) {
    //   emit(state.copyWith(message: e.toString(), status: LoginStatus.failure));
   //}
  }
}