import 'package:flutter/cupertino.dart';
import 'package:glboard_web/src/constants.dart';
import 'package:glboard_web/src/shared/service_http.dart';

enum InsertGameProfState { idle, success, error, loading }

class InsertGameProfController extends ChangeNotifier {
  var state = InsertGameProfState.idle;
  String error = "";
  String gameToken = "";
  String nameGame = "";

  final ClientHttp clientHttp;

  InsertGameProfController(this.clientHttp);

  Future<void> insertGame() async {
    state = InsertGameProfState.loading;
    notifyListeners();

    String url = "${urlbackend}/users/games_prof";
    try {
      var result = await clientHttp.post(
        url,
        {
          "id_user": globalUserModel.iduser,
          "game_id": gameToken,
          "name": nameGame,
        },
      );
      state = InsertGameProfState.success;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      state = InsertGameProfState.error;
      notifyListeners();
      state = InsertGameProfState.idle;
      notifyListeners();
    }
  }
}
