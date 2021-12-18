import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:glboard_web/src/constants.dart';
import 'package:glboard_web/src/features/general_analysis/general_analysis_controller.dart';
import 'package:glboard_web/src/features/sidebar/sider_bar.dart';
import 'package:glboard_web/src/shared/widgets.dart';
import 'package:provider/provider.dart';

class GeneralAnalysis extends StatefulWidget {
  const GeneralAnalysis({Key? key}) : super(key: key);

  @override
  _GeneralAnalysisState createState() => _GeneralAnalysisState();
}

class _GeneralAnalysisState extends State<GeneralAnalysis> {
  late final GeneralAnalysisController controller;

  @override
  void initState() {
    super.initState();

    controller = context.read<GeneralAnalysisController>();

    controller.addListener(() {
      if (controller.state == GeneralAnalysisState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(controller.error)),
        );
      }
    });

    //! TODO -> Não sei sei se é a melhor solução, porém chamada o fetch somente no fim do ciclo do initstate
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      controller.fetchGeneralAnalysis(selectedGameID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(),
      body: const PageGeneralAnalysis(),
    );
  }
}

class PageGeneralAnalysis extends StatelessWidget {
  const PageGeneralAnalysis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GeneralAnalysisController>();
    var generalAnalysis = controller.generalAnalysisModel;

    var size = MediaQuery.of(context).size;

    return controller.state == GeneralAnalysisState.loading
        ? CommonWidgets.loading()
        : Scaffold(
            body: Container(
              alignment: Alignment.center,
              width: size.width,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Análises Gerais", style: TextStyle(fontSize: 30)),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonWidgets.cardInfoData(
                        "Jogadores",
                        generalAnalysis.quantPlayers.toString(),
                      ),
                      const SizedBox(width: 30),
                      CommonWidgets.cardInfoData(
                        "Fases",
                        generalAnalysis.averagePerfomacePhaseTotal?.length
                                .toString() ??
                            "",
                      ),
                      const SizedBox(width: 30),
                      CommonWidgets.cardInfoData(
                        "Minutos Jogados",
                        generalAnalysis.quantMinutesInSession.toString(),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return DialogDaysSections(
                            generalAnalysis.sectionsDay,
                          );
                        },
                      );
                    },
                    child: const Text(
                      "Clique aqui e visualize as seções realizadas por dia",
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 400,
                        height: 200,
                        child: CommonWidgets.chartBar(
                          "Quantidade Conclusão Fases",
                          controller.conclusionPhaseDataChart(),
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        height: 200,
                        child: CommonWidgets.chartBar(
                          "Média de Desempenho em Fases",
                          controller.avaragePerfomancePhaseDataChart(),
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        height: 200,
                        child: CommonWidgets.chartBar(
                          "Tentativas por Fase",
                          controller.attemptsPhaseDataChart(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 400,
                        height: 200,
                        child: CommonWidgets.chartBar(
                          "Minutos por Fases",
                          controller.timeInPhaseDataChart(),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}

class DialogDaysSections extends StatelessWidget {
  final Map<String, dynamic>? sectionsDays;
  const DialogDaysSections(this.sectionsDays, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mapKeys = sectionsDays?.keys.toList();
    var mapValues = sectionsDays?.values.toList();

    return AlertDialog(
      title: const Text("Seções Realizadas Por Dia"),
      content: SizedBox(
        height: 400,
        width: 200,
        child: ListView.builder(
          itemCount: sectionsDays?.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("Dia ${mapKeys?[index]}"),
              subtitle: Text("Seções: ${mapValues?[index]}"),
            );
          },
        ),
      ),
    );
  }
}
