import 'package:flutter/cupertino.dart';
import 'package:glboard_web/src/constants.dart';
import 'package:glboard_web/src/features/register_user/models/register_model.dart';
import 'package:glboard_web/src/shared/service_http.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum RegisterState { idle, success, error, loading }

class RegisterController extends ChangeNotifier {
  var state = RegisterState.idle;

  final ClientHttp clientHttp;

  String error = "";
  String _selectedRadio = "";

  RegisterController(this.clientHttp);
  var userModel = UserModel("", "", "");

  onChangeRadioButton(String value) {
    _selectedRadio = value;
    notifyListeners();
  }

  get selectedRadio => _selectedRadio;
  set selectedRadio(value) {
    _selectedRadio = value;
    userModel.typeruser = value;
    notifyListeners();
  }

  Future<void> registerUser() async {
    state = RegisterState.loading;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));
    String url = "${urlbackend}/users/register";
    try {
      await clientHttp.post(url, userModel.toMap());
      final shared = await SharedPreferences.getInstance();
      globalUserModel = userModel;
      await shared.setString('UserModel', globalUserModel.toJson());
      state = RegisterState.success;
      notifyListeners();
      state = RegisterState.idle;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      state = RegisterState.error;
      notifyListeners();
      state = RegisterState.idle;
      notifyListeners();
    }
  }
}
