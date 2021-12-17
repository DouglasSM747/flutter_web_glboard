import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:glboard_web/src/constants.dart';
import 'package:glboard_web/src/shared/service_http.dart';

import 'models/list_games_dev_model.dart';

enum ListGamesDevState { idle, success, error, loading }

class ListGamesDevController extends ChangeNotifier {
  var state = ListGamesDevState.idle;
  String error = "";

  final ClientHttp clientHttp;

  ListGamesDevController(this.clientHttp) {
    _fetchGames();
  }

  List<GameDevModel> listGamesDev = List.empty();

  Future<void> _fetchGames() async {
    state = ListGamesDevState.loading;
    notifyListeners();

    if (listGamesDev.isNotEmpty) return;

    String url = "$urlbackend/users/games";

    try {
      var result = await clientHttp.get(
        url,
        {"id_user": globalUserModel.iduser},
      );

      listGamesDev = _jsonToListGames(result);

      state = ListGamesDevState.success;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      state = ListGamesDevState.error;
      notifyListeners();
      state = ListGamesDevState.idle;
      notifyListeners();
    }
  }

  Future<void> refreshGames() async {
    state = ListGamesDevState.loading;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));

    String url = "$urlbackend/users/games";

    try {
      var result = await clientHttp.get(
        url,
        {"id_user": globalUserModel.iduser},
      );
      listGamesDev = _jsonToListGames(result);
      state = ListGamesDevState.success;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      state = ListGamesDevState.error;
      notifyListeners();
      state = ListGamesDevState.idle;
      notifyListeners();
    }
  }

  List<GameDevModel> _jsonToListGames(data) {
    var tagObjsJson = data['games'] as List;

    return tagObjsJson
        .map(
          (tagJson) => GameDevModel.fromJson(tagJson),
        )
        .toList();
  }
}
