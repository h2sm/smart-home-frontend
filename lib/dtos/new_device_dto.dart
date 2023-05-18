class AddedDevice {
  String _deviceName;
  String _deviceLocation;
  String _deviceSerial;
  String _deviceLocalIpAddress;
  String _hubUuid;

  AddedDevice({
    required String deviceName,
    required String deviceLocation,
    required String deviceSerial,
    required String deviceLocalIpAddress,
    required String hubUuid,
  })  : _deviceName = deviceName,
        _deviceLocation = deviceLocation,
        _deviceSerial = deviceSerial,
        _deviceLocalIpAddress = deviceLocalIpAddress,
        _hubUuid = hubUuid;

  String get hubUuid => _hubUuid;

  String get deviceName => _deviceName;

  String get deviceLocation => _deviceLocation;

  String get deviceSerial => _deviceSerial;

  String get deviceLocalIpAddress => _deviceLocalIpAddress;

  Map<String, dynamic> toJson() {
    return {
      'deviceType': "BULB",
      'deviceName': _deviceName,
      'deviceLocation': _deviceLocation,
      'deviceSerial' : _deviceSerial,
      'localIpAddress':_deviceLocalIpAddress,
      'hubUuid': _hubUuid,
    };
  }
}
