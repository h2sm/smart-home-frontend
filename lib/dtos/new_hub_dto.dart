class NewHubDTO {
  String _hubUuid;
  String _hubName;
  String _hubSecret;

  NewHubDTO({
    required String hubUuid,
    required String hubName,
    required String hubSecret,
  })  : _hubUuid = hubUuid,
        _hubName = hubName,
        _hubSecret = hubSecret;

  String get hubUuid => _hubUuid;

  String get hubName => _hubName;

  String get hubSecret => _hubSecret;

  Map<String, dynamic> toJson() {
    return {
      'hubUuid': _hubUuid,
      'hubName': _hubName,
      'hubSecret': _hubSecret,
    };
  }
}
