class PlayerGeralInfo {
  String name = "";
  String lastLogin = "";
  int conclusionPhases = 0;
  String apiUser = "";

  PlayerGeralInfo({
    this.name = "",
    this.lastLogin = "",
    this.conclusionPhases = 0,
    this.apiUser = "",
  });

  PlayerGeralInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lastLogin = json['last_login'];
    conclusionPhases = json['conclusion_phases'];
    apiUser = json['api_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['last_login'] = lastLogin;
    data['conclusion_phases'] = conclusionPhases;
    data['api_user'] = apiUser;
    return data;
  }
}
