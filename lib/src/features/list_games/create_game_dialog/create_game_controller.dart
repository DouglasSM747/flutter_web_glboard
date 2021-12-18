import 'package:flutter/cupertino.dart';
import 'package:glboard_web/src/constants.dart';
import 'package:glboard_web/src/shared/service_http.dart';

enum CreateGameDevState { idle, success, error, loading }

class CreateGameDevController extends ChangeNotifier {
  var state = CreateGameDevState.idle;
  String error = "";
  String nameGame = "";
  String descriptionGame = "";

  final ClientHttp clientHttp;

  CreateGameDevController(this.clientHttp);

  Future<void> createGame() async {
    state = CreateGameDevState.loading;
    notifyListeners();

    String url = "${urlbackend}/users/games";
    try {
      var result = await clientHttp.post(
        url,
        {
          "id_user": globalUserModel.iduser,
          "nameGame": nameGame,
          "description": descriptionGame,
        },
      );
      state = CreateGameDevState.success;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      state = CreateGameDevState.error;
      notifyListeners();
      state = CreateGameDevState.idle;
      notifyListeners();
    }
  }
}
