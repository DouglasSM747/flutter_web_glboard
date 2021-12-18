import 'package:flutter/material.dart';
import 'package:glboard_web/src/features/list_games/insert_game_prof_dialog/insert_game_prof_controller.dart';
import 'package:glboard_web/src/shared/widgets.dart';
import 'package:provider/provider.dart';

class InsertGameProf extends StatelessWidget {
  const InsertGameProf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final controller = context.watch<InsertGameProfController>();

    return AlertDialog(
      title: const Text("Inserir Novo Jogo"),
      content: Column(
        children: [
          CommonWidgets.inputText(
            "Digite o Nome para Identificar o jogo...",
            onpress: () {},
            onChanged: (String? value) {
              controller.nameGame = value ?? "";
            },
          ),
          CommonWidgets.inputText(
            "Digite o Token do jogo...",
            onpress: () {},
            onChanged: (String? value) {
              controller.gameToken = value ?? "";
            },
          ),
          const SizedBox(height: 40),
          CommonWidgets.buttonDefault(
            "Inserir Jogo",
            callback: controller.state != InsertGameProfState.loading
                ? () {
                    controller.insertGame();
                    Navigator.of(context).pop();
                  }
                : null,
          )
        ],
      ),
    );
  }
}
