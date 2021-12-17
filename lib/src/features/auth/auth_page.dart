// ignore_for_file: sized_box_for_whitespace
import 'package:glboard_web/src/features/initi_page.dart';
import 'package:glboard_web/src/features/list_games/list_games_dev_page.dart';
import 'package:glboard_web/src/shared/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:glboard_web/src/features/auth/auth_controller.dart';

import 'components/auth_password.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final AuthController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<AuthController>();

    controller.addListener(() {
      if (controller.state == AuthState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(controller.error)),
        );
      } else if (controller.state == AuthState.success) {
        Navigator.of(context).pushReplacementNamed('/listgamesdev');
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: null,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "GLBoard",
              style: TextStyle(fontSize: 50),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: screenSize.width / 3,
              child: const _FormLogin(),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              child: const Text("Não possui conta? Crie uma..."),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/register');
              },
            )
          ],
        ),
      ),
    );
  }
}

class _FormLogin extends StatelessWidget {
  const _FormLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();
    //! TODO => NAO SEI SE DEVO FAZER ISSO
    return controller.state != AuthState.loading
        ? Column(
            children: [
              const EmailInput(),
              const SizedBox(height: 30),
              const PasswordInput(),
              const SizedBox(height: 40),
              CommonWidgets.buttonDefault("Entrar", callback: () {
                controller.login();
              }),
            ],
          )
        : CommonWidgets.loading();
  }
}
