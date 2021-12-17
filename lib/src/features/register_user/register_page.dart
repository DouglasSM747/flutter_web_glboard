import 'package:flutter/material.dart';
import 'package:glboard_web/src/features/register_user/register_controller.dart';
import 'package:glboard_web/src/shared/widgets.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final RegisterController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<RegisterController>();

    controller.addListener(() {
      if (controller.state == RegisterState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(controller.error)),
        );
      } else if (controller.state == RegisterState.success) {
        Navigator.of(context).pushReplacementNamed('/auth');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: null,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Crie uma conta",
              style: TextStyle(fontSize: 50),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: size.width / 3,
              child: Column(
                children: [
                  CommonWidgets.inputText(
                    "Digite seu email...",
                    onpress: () {},
                    onChanged: (String? value) {
                      controller.userModel.email = value ?? "";
                    },
                  ),
                  const SizedBox(height: 20),
                  CommonWidgets.inputText(
                    "Digite sua senha...",
                    onpress: () {},
                    onChanged: (String? value) {
                      controller.userModel.password = value ?? "";
                    },
                  ),
                  const SizedBox(height: 20),
                  const RadioRegister(),
                  const SizedBox(height: 20),
                  const ButtonRegister(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RadioRegister extends StatelessWidget {
  const RadioRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RegisterController>();
    //! DA PARA MELHORAR, COLOCAR ARRAY DE WIDGETS
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonWidgets.radioCheck(
              "Desenvolvedor",
              controller.selectedRadio,
              (value) => controller.selectedRadio = value,
            ),
            const Text("Desenvolvedor"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonWidgets.radioCheck(
              "Professor",
              controller.selectedRadio,
              (value) => controller.selectedRadio = value,
            ),
            const Text("Professor"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonWidgets.radioCheck(
              "Jogador",
              controller.selectedRadio,
              (value) => controller.selectedRadio = value,
            ),
            const Text("Jogador"),
          ],
        )
      ],
    );
  }
}

class ButtonRegister extends StatelessWidget {
  const ButtonRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RegisterController>();
    return CommonWidgets.buttonDefault(
      "Criar Conta",
      callback: controller.state == RegisterState.loading
          ? null
          : () => controller.registerUser(),
    );
  }
}
