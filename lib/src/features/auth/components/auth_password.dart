import 'package:flutter/material.dart';
import 'package:glboard_web/src/features/auth/auth_controller.dart';
import 'package:glboard_web/src/shared/widgets.dart';
import 'package:provider/provider.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();
    return CommonWidgets.inputText(
      "Digite sua senha...",
      onpress: () {
        controller.changeShowPassword();
      },
      onChanged: (value) {
        controller.userModel.password = value ?? "";
      },
      isObscureText: controller.showPassword,
      useIcon: true,
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();
    return CommonWidgets.inputText(
      "Digite seu email...",
      onChanged: (String? value) {
        controller.userModel.email = value ?? "";
      },
      onpress: () {},
    );
  }
}
