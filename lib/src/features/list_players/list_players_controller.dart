import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:glboard_web/src/constants.dart';
import 'package:glboard_web/src/shared/service_http.dart';

import 'models/player_geral_info_model.dart';

enum ListPlayersState { idle, success, error, loading }

class ListPlayersController extends ChangeNotifier {
  var state = ListPlayersState.idle;
  String error = "";

  final ClientHttp clientHttp;

  List<PlayerGeralInfo> playersModel = [];

  ListPlayersController(this.clientHttp);

  Future<void> fetchPlayersGame(String gameID) async {
    playersModel = [];

    state = ListPlayersState.loading;
    notifyListeners();

    String url = "$urlbackend/data-game/users/$gameID";

    try {
      var result = await clientHttp.get(url, {});

      for (var element in result) {
        playersModel.add(PlayerGeralInfo.fromJson(element));
      }

      state = ListPlayersState.success;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      state = ListPlayersState.error;
      notifyListeners();
      state = ListPlayersState.idle;
      notifyListeners();
    }
  }

  Future<void> refreshGames(String gameID) async {
    state = ListPlayersState.loading;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));

    String url = "$urlbackend/data-game/$gameID";

    try {
      var result = await clientHttp.get(url, {});
      state = ListPlayersState.success;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      state = ListPlayersState.error;
      notifyListeners();
      state = ListPlayersState.idle;
      notifyListeners();
    }
  }
}
