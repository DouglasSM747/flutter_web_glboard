import 'package:flutter/cupertino.dart';
import 'package:glboard_web/src/constants.dart';
import 'package:glboard_web/src/features/register_user/models/register_model.dart';
import 'package:glboard_web/src/shared/service_http.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthState { idle, success, error, loading }

class AuthController extends ChangeNotifier {
  bool _showPassword = true;

  final ClientHttp clientHttp;

  String error = "";

  var state = AuthState.idle;

  var userModel = UserModel("", "", "");

  AuthController(this.clientHttp);

  get showPassword => _showPassword;

  changeShowPassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  Future<void> login() async {
    state = AuthState.loading;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));
    String url = "$urlbackend/users/login";
    try {
      var result = await clientHttp.post(url, userModel.toMap());
      final shared = await SharedPreferences.getInstance();

      globalUserModel = userModel;
      globalUserModel.iduser = result['id_user'];
      globalUserModel.typeruser = result['type_user'];

      await shared.setString('UserModel', globalUserModel.toJson());
      state = AuthState.success;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      state = AuthState.error;
      notifyListeners();
      state = AuthState.idle;
      notifyListeners();
    }
  }
}
