class GameDevModel {
  String _name = "";
  String _key = "";
  int _countPlayers = 0;

  GameDevModel(
    String name,
    String key,
    int countPlayers,
  ) {
    _name = name;
    _key = key;
    _countPlayers = countPlayers;
  }

  String get name => _name;
  set name(String name) => _name = name;
  String get key => _key;
  set key(String key) => _key = key;
  int get countPlayers => _countPlayers;
  set countPlayers(int countPlayers) => _countPlayers = countPlayers;

  GameDevModel.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _key = json['key'];
    _countPlayers = json['countPlayers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = _name;
    data['key'] = _key;
    data['countPlayers'] = _countPlayers;
    return data;
  }
}
