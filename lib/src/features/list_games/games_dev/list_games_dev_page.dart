import 'package:flutter/material.dart';
import 'package:glboard_web/src/constants.dart';
import 'package:glboard_web/src/features/initi_page.dart';
import 'package:glboard_web/src/features/list_games/create_game_dialog/create_game_page.dart';
import 'package:glboard_web/src/features/list_games/games_dev/list_games_dev_controller.dart';
import 'package:glboard_web/src/shared/widgets.dart';
import 'package:provider/provider.dart';

class ListGamesDev extends StatefulWidget {
  const ListGamesDev({Key? key}) : super(key: key);

  @override
  _ListGamesDevState createState() => _ListGamesDevState();
}

class _ListGamesDevState extends State<ListGamesDev> {
  late final ListGamesDevController controller;

  @override
  void initState() {
    super.initState();
    if (globalUserModel.iduser.isEmpty) {
      Navigator.of(context).pushReplacementNamed('/auth');
    }

    controller = context.read<ListGamesDevController>();

    controller.addListener(() {
      if (controller.state == ListGamesDevState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(controller.error)),
        );
      } else if (controller.state == ListGamesDevState.success) {
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
                      "Tabela de Jogos do Desenvolvedor",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      width: 200,
                      height: 40,
                      child: CommonWidgets.buttonDefault(
                        "Cadastrar Novo Jogo",
                        callback: () async {
                          await showDialog(
                            context: context,
                            builder: (_) {
                              return const CreteGameDev();
                            },
                          );
                          controller.refreshGames();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const ListViewGamesDev(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ListViewGamesDev extends StatelessWidget {
  const ListViewGamesDev({Key? key}) : super(key: key);

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
    final controller = context.watch<ListGamesDevController>();
    return controller.state != ListGamesDevState.loading
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
                controller.listGamesDev.length,
                (index) {
                  return [
                    controller.listGamesDev[index].name,
                    controller.listGamesDev[index].key,
                    controller.listGamesDev[index].countPlayers.toString(),
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
