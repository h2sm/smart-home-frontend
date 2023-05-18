import 'package:flutter/cupertino.dart';
import '../../dtos/device_dto.dart';

class CameraDeviceInfo extends StatefulWidget{
  const CameraDeviceInfo({super.key, required this.device});

  final Device device;
  @override
  State<StatefulWidget> createState() {
    return _CameraDeviceInfoState();
  }

}

class _CameraDeviceInfoState extends State<CameraDeviceInfo>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}