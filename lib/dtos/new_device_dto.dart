class AddedDevice {
  String _deviceName;
  String _deviceLocation;
  String _deviceSerial;
  String _deviceLocalIpAddress;
  int _hubId;

  AddedDevice({
    required String deviceName,
    required String deviceLocation,
    required String deviceSerial,
    required String deviceLocalIpAddress,
    required int hubId,
  })  : _deviceName = deviceName,
        _deviceLocation = deviceLocation,
        _deviceSerial = deviceSerial,
        _deviceLocalIpAddress = deviceLocalIpAddress,
        _hubId = hubId;

  int get hubId => _hubId;

  String get deviceName => _deviceName;

  String get deviceLocation => _deviceLocation;

  String get deviceSerial => _deviceSerial;

  String get deviceLocalIpAddress => _deviceLocalIpAddress;
}
