import 'package:flutter/cupertino.dart';
import 'package:glboard_web/src/constants.dart';
import 'package:glboard_web/src/shared/service_http.dart';
import '../models/list_games_dev_model.dart';

enum ListGamesPlayerState { idle, success, error, loading }

class ListGamesPlayerController extends ChangeNotifier {
  var state = ListGamesPlayerState.idle;
  String error = "";

  final ClientHttp clientHttp;

  ListGamesPlayerController(this.clientHttp) {
    _fetchGames();
  }

  List<GameGeralInfoModel> listGamesPlayer = List.empty();

  Future<void> _fetchGames() async {
    if (listGamesPlayer.isNotEmpty) return;

    state = ListGamesPlayerState.loading;
    notifyListeners();

    String url = "$urlbackend/users/games_player";

    try {
      var result = await clientHttp.get(
        url,
        {
          "email": globalUserModel.email,
        },
      );
      listGamesPlayer = _jsonToListGames(result);

      state = ListGamesPlayerState.success;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      state = ListGamesPlayerState.error;
      notifyListeners();
      state = ListGamesPlayerState.idle;
      notifyListeners();
    }
  }

  Future<void> refreshGames() async {
    state = ListGamesPlayerState.loading;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));

    String url = "$urlbackend/users/games_player";

    try {
      var result = await clientHttp.get(
        url,
        {
          "email": globalUserModel.email,
        },
      );
      listGamesPlayer = _jsonToListGames(result);
      state = ListGamesPlayerState.success;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      state = ListGamesPlayerState.error;
      notifyListeners();
      state = ListGamesPlayerState.idle;
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
