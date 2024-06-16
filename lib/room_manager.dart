class RoomManager {
  static final RoomManager _instance = RoomManager._internal();
  String? _roomId;

  factory RoomManager() {
    return _instance;
  }

  RoomManager._internal();

  String? get roomId => _roomId;

  void generateRoomId(String id) {
    _roomId = id;
  }

  void clearRoomId() {
    _roomId = null;
  }
}
