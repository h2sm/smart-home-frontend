import 'package:flutter/cupertino.dart';

import '../../dtos/device_dto.dart';

class BulbDeviceInfo extends StatefulWidget{
  const BulbDeviceInfo({super.key, required this.device});

  final Device device;
  @override
  State<StatefulWidget> createState() {
    return _BulbDeviceInfoState();
  }

}

class _BulbDeviceInfoState extends State<BulbDeviceInfo>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}