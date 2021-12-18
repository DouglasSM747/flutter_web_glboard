import 'package:flutter/cupertino.dart';
import 'package:glboard_web/src/constants.dart';
import 'package:glboard_web/src/shared/service_http.dart';
import '../models/list_games_dev_model.dart';

enum ListGamesProfState { idle, success, error, loading }

class ListGamesProfController extends ChangeNotifier {
  var state = ListGamesProfState.idle;
  String error = "";

  final ClientHttp clientHttp;

  ListGamesProfController(this.clientHttp) {
    _fetchGames();
  }

  List<GameGeralInfoModel> listGamesProf = List.empty();

  Future<void> _fetchGames() async {
    if (listGamesProf.isNotEmpty) return;

    state = ListGamesProfState.loading;
    notifyListeners();

    String url = "${urlbackend}/users/games_prof";

    try {
      var result = await clientHttp.get(
        url,
        {"id_user": globalUserModel.iduser},
      );
      listGamesProf = _jsonToListGames(result);

      state = ListGamesProfState.success;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      state = ListGamesProfState.error;
      notifyListeners();
      state = ListGamesProfState.idle;
      notifyListeners();
    }
  }

  Future<void> refreshGames() async {
    state = ListGamesProfState.loading;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));

    String url = "${urlbackend}/users/games_prof";

    try {
      var result = await clientHttp.get(
        url,
        {
          "id_user": globalUserModel.iduser,
        },
      );

      listGamesProf = _jsonToListGames(result);
      state = ListGamesProfState.success;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      state = ListGamesProfState.error;
      notifyListeners();
      state = ListGamesProfState.idle;
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
