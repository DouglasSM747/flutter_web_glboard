import 'package:flutter/cupertino.dart';
import 'package:glboard_web/src/constants.dart';
import '../models/list_games_dev_model.dart';
import 'package:glboard_web/src/shared/service_http.dart';

enum ListGamesDevState { idle, success, error, loading }

class ListGamesDevController extends ChangeNotifier {
  var state = ListGamesDevState.idle;
  String error = "";

  final ClientHttp clientHttp;

  ListGamesDevController(this.clientHttp) {
    _fetchGames();
  }

  List<GameGeralInfoModel> listGamesDev = List.empty();

  Future<void> _fetchGames() async {
    if (listGamesDev.isNotEmpty) return;

    state = ListGamesDevState.loading;
    notifyListeners();

    String url = "${urlbackend}/users/games_dev";

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

    String url = "$urlbackend/users/games_dev";

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

  List<GameGeralInfoModel> _jsonToListGames(data) {
    var tagObjsJson = data['games'] as List;

    return tagObjsJson
        .map(
          (tagJson) => GameGeralInfoModel.fromJson(tagJson),
        )
        .toList();
  }
}
