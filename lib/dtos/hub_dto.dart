class HubDTO {
  String _hubUuid;
  String _hubName;

  HubDTO({
    required String hubUuid,
    required String hubName,
  })  : _hubUuid = hubUuid,
        _hubName = hubName;

  String get hubUuid => _hubUuid;

  String get hubName => _hubName;

  factory HubDTO.fromJson(Map<String, dynamic> json) {
    return HubDTO(
      hubUuid: json['hubUuid'],
      hubName: json['hubName'],
    );
  }
}
