class Device {

  int deviceId;
  final String type;
  final String deviceName;
  final String deviceLocation;
  final String localIpAddress;
  final String deviceSerial;
  Map<String,dynamic> details;

  Device({
    required this.type,
    required this.deviceId,
    required this.deviceName,
    required this.deviceLocation,
    required this.deviceSerial,
    required this.localIpAddress,
    required this.details,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      type: json['type'],
      deviceId: json['deviceId'],
      deviceName: json['deviceName'],
      deviceLocation: json['deviceLocation'],
      deviceSerial: json['deviceSerial'],
      localIpAddress: json['localDeviceIp'],
      details: json['details'],
    );
  }
}