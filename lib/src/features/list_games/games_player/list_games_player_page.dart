import 'package:flutter/material.dart';
import 'package:glboard_web/src/constants.dart';
import 'package:glboard_web/src/features/individual_analysis/individual_analysis_page.dart';
import 'package:glboard_web/src/features/initi_page.dart';
import 'package:glboard_web/src/features/list_games/games_player/list_games_player_controller.dart';
import 'package:glboard_web/src/features/list_games/insert_game_player_dialog/insert_game_player_page.dart';
import 'package:glboard_web/src/shared/widgets.dart';
import 'package:provider/provider.dart';

class ListGamesPlayer extends StatefulWidget {
  const ListGamesPlayer({Key? key}) : super(key: key);

  @override
  _ListGamesPlayerState createState() => _ListGamesPlayerState();
}

class _ListGamesPlayerState extends State<ListGamesPlayer> {
  late final ListGamesPlayerController controller;

  @override
  void initState() {
    super.initState();
    if (globalUserModel.iduser.isEmpty) {
      Navigator.of(context).pushReplacementNamed('/auth');
    }

    controller = context.read<ListGamesPlayerController>();

    controller.addListener(() {
      if (controller.state == ListGamesPlayerState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(controller.error)),
        );
      } else if (controller.state == ListGamesPlayerState.success) {
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
                      "Tabela de Jogos do Jogador",
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
                              return const InsertGamePlayer();
                            },
                          );
                          controller.refreshGames();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const ListViewGamesPlayer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ListViewGamesPlayer extends StatelessWidget {
  const ListViewGamesPlayer({Key? key}) : super(key: key);

  void goToIndividualAnalysis(context, String gameUserID) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      settings: const RouteSettings(name: '/individual_analysis'),
      builder: (context) => IndividualAnalysis(gameUserID),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final controller = context.watch<ListGamesPlayerController>();

    return controller.state != ListGamesPlayerState.loading
        ? Container(
            alignment: Alignment.center,
            width: size.width - 300,
            height: size.height - 300,
            child: CommonWidgets.table(
              [
                "Nome do Jogo",
                "Chave do Jogo",
              ],
              List.generate(
                controller.listGamesPlayer.length,
                (index) {
                  return [
                    controller.listGamesPlayer[index].name,
                    controller.listGamesPlayer[index].key,
                  ];
                },
              ),
              clicked: true,
              columnClick: 1,
              function: (value) => goToIndividualAnalysis(context, value),
            ),
          )
        : CommonWidgets.loading();
  }
}
