import 'package:flutter/material.dart';
import 'package:glboard_web/src/constants.dart';
import 'package:glboard_web/src/features/initi_page.dart';
import 'package:glboard_web/src/features/list_games/insert_game_prof_dialog/insert_game_prof_page.dart';
import 'package:glboard_web/src/shared/widgets.dart';
import 'package:provider/provider.dart';

import 'list_games_prof_controller.dart';

class ListGamesProf extends StatefulWidget {
  const ListGamesProf({Key? key}) : super(key: key);

  @override
  _ListGamesProfState createState() => _ListGamesProfState();
}

class _ListGamesProfState extends State<ListGamesProf> {
  late final ListGamesProfController controller;

  @override
  void initState() {
    super.initState();
    if (globalUserModel.iduser.isEmpty) {
      Navigator.of(context).pushReplacementNamed('/auth');
    }

    controller = context.read<ListGamesProfController>();

    controller.addListener(() {
      if (controller.state == ListGamesProfState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(controller.error)),
        );
      } else if (controller.state == ListGamesProfState.success) {
        // Navigator.of(context).pushReplacementNamed('/auth');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Tabela de Jogos do Professor",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      width: 200,
                      height: 40,
                      child: CommonWidgets.buttonDefault(
                        "Inserir Jogo",
                        callback: () async {
                          await showDialog(
                            context: context,
                            builder: (_) {
                              return const InsertGameProf();
                            },
                          );
                          controller.refreshGames();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const ListViewGamesProf(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ListViewGamesProf extends StatelessWidget {
  const ListViewGamesProf({Key? key}) : super(key: key);

  void goToGeneralAnalysis(context, String gameID) {
    selectedGameID = gameID;
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      settings: const RouteSettings(name: '/general_analysis'),
      builder: (context) => const MainPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final controller = context.watch<ListGamesProfController>();

    return controller.state != ListGamesProfState.loading
        ? Container(
            alignment: Alignment.center,
            width: size.width - 300,
            height: size.height - 300,
            child: CommonWidgets.table(
              [
                "Nome do Jogo",
                "Chave do Jogo",
                "Quantidade Jogadores",
              ],
              List.generate(
                controller.listGamesProf.length,
                (index) {
                  return [
                    controller.listGamesProf[index].name,
                    controller.listGamesProf[index].key,
                    controller.listGamesProf[index].countPlayers.toString(),
                  ];
                },
              ),
              clicked: true,
              columnClick: 1,
              function: (value) => goToGeneralAnalysis(context, value),
            ),
          )
        : CommonWidgets.loading();
  }
}
