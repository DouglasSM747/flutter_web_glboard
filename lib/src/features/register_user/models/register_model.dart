import 'dart:convert';

class UserModel {
  String _password = "";
  String _email = "";
  String _typeruser = "";
  String iduser = "";

  UserModel(this._email, this._password, this._typeruser);

  String get email => _email;
  String get password => _password;
  String get typeruser => _typeruser;
  // String get iduser => _typeruser;

  set email(String email) => _email = email;
  set password(String password) => _password = password;
  set typeruser(String typeruser) => _typeruser = typeruser;
  // set iduser(String iduser) => _iduser = iduser;

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'type_user': typeruser,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['email'],
      map['password'],
      map['typeuser'],
    );
  }

  String toJson() => json.encode(toMap());
}
