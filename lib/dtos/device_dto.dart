class Device {

  final int id;
  bool isOn;
  final String deviceName;
  final String deviceLocation;
  final String deviceSerial;
  final String localIpAddress;
  List<int> brgbValues;

  Device({
    required this.id,
    required this.isOn,
    required this.deviceName,
    required this.deviceLocation,
    required this.deviceSerial,
    required this.localIpAddress,
    required this.brgbValues,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      isOn: json['isOn'],
      deviceName: json['deviceName'],
      deviceLocation: json['deviceLocation'],
      deviceSerial: json['deviceSerial'],
      localIpAddress: json['localIpAddress'],
      brgbValues: json['brgbValues'],
    );
  }
}