import 'package:equatable/equatable.dart';
import '../../../dtos/device_dto.dart';

abstract class ContentEvent extends Equatable {
  const ContentEvent([List props = const []]);
}

class ContentRequested extends ContentEvent {
  const ContentRequested({required this.listOfDevices});
  final List<Device> listOfDevices;
  @override
  // TODO: implement props
  List<Object?> get props => [listOfDevices];
}

class ContentObtained extends ContentEvent {
  const ContentObtained({required this.listOfDevices});
  final List<Device> listOfDevices;
  @override
  // TODO: implement props
  List<Object?> get props => [listOfDevices];

}

class ContentRequestFailed extends ContentEvent {
  const ContentRequestFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];

}
