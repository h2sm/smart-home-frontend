class HubDTO {
  int _hubId;
  String _hubName;

  HubDTO({
    required int hubId,
    required String hubName,
  })  : _hubId = hubId,
        _hubName = hubName;

  int get hubId => _hubId;

  String get hubName => _hubName;

  factory HubDTO.fromJson(Map<String, dynamic> json) {
    return HubDTO(
      hubId: json['hubId'],
      hubName: json['hubName'],
    );
  }
}
