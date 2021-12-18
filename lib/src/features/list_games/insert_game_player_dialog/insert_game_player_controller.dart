import 'package:flutter/cupertino.dart';
import 'package:glboard_web/src/constants.dart';
import 'package:glboard_web/src/shared/service_http.dart';

enum InsertGamePlayerState { idle, success, error, loading }

class InsertGamePlayerController extends ChangeNotifier {
  var state = InsertGamePlayerState.idle;
  String error = "";
  String gameToken = "";
  String nameGame = "";

  final ClientHttp clientHttp;

  InsertGamePlayerController(this.clientHttp);

  Future<void> insertGame() async {
    state = InsertGamePlayerState.loading;
    notifyListeners();

    String url = "$urlbackend/users/games_player";
    try {
      var result = await clientHttp.post(url, {
        "game_user_id": gameToken,
        "name": nameGame,
        "email": globalUserModel.email,
      });
      state = InsertGamePlayerState.success;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      state = InsertGamePlayerState.error;
      notifyListeners();
      state = InsertGamePlayerState.idle;
      notifyListeners();
    }
  }
}
