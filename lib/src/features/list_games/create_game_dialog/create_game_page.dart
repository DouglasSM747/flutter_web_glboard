import 'package:flutter/material.dart';
import 'package:glboard_web/src/features/list_games/create_game_dialog/create_game_controller.dart';
import 'package:glboard_web/src/shared/widgets.dart';
import 'package:provider/provider.dart';

class CreteGameDev extends StatelessWidget {
  const CreteGameDev({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final controller = context.watch<CreateGameDevController>();

    return AlertDialog(
      title: const Text("Criar Novo Jogo"),
      content: Column(
        children: [
          CommonWidgets.inputText(
            "Digite o nome do jogo...",
            onpress: () {},
            onChanged: (String? value) {
              controller.nameGame = value ?? "";
            },
          ),
          const SizedBox(height: 40),
          CommonWidgets.inputText(
            "Digite a descrição do jogo...",
            onpress: () {},
            onChanged: (String? value) {
              controller.descriptionGame = value ?? "";
            },
          ),
          const SizedBox(height: 40),
          CommonWidgets.buttonDefault(
            "Cadastrar Novo Jogo",
            callback: controller.state != CreateGameDevState.loading
                ? () {
                    controller.createGame();
                    Navigator.of(context).pop();
                  }
                : null,
          )
        ],
      ),
    );
  }
}
