import 'package:equatable/equatable.dart';
import '../../../dtos/device_dto.dart';

class ContentState extends Equatable {
  const ContentState({
    this.listOfDevices = const <Device>[],
  });

  final List<Device> listOfDevices;

  ContentState copyWith({required List<Device> listOfDevice}) {
    return ContentState(listOfDevices: listOfDevice);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [listOfDevices];
}

class ContentInitial extends ContentState {}

class ContentDownloadInProgress extends ContentState {}

class ContendDownloadSuccess extends ContentState {}

class ContentDownloadFailure extends ContentState {}
