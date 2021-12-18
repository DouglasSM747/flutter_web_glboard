import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:glboard_web/src/features/general_analysis/general_analysis_page.dart';
import 'package:glboard_web/src/features/sidebar/sider_bar.dart';
import 'package:glboard_web/src/shared/widgets.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'individual_analysis_controller.dart';

class IndividualAnalysis extends StatefulWidget {
  final String gameUserId;

  const IndividualAnalysis(this.gameUserId, {Key? key}) : super(key: key);

  @override
  _IndividualAnalysisState createState() => _IndividualAnalysisState();
}

class _IndividualAnalysisState extends State<IndividualAnalysis> {
  late final IndividualAnalysisController controller;

  @override
  void initState() {
    super.initState();

    controller = context.read<IndividualAnalysisController>();

    controller.addListener(() {
      if (controller.state == IndividualAnalysisState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(controller.error)),
        );
      }
    });

    //! TODO -> Não sei sei se é a melhor solução, porém chamada o fetch somente no fim do ciclo do initstate
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (mounted) {
        controller.fetchIndividualAnalysis(widget.gameUserId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: globalUserModel.typeruser != "Jogador"
          ? const NavigationDrawerWidget()
          : null,
      appBar: AppBar(),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: ListView(
          children: [
            SizedBox(
              width: size.width - 100,
              height: size.height - 50,
              child: const PageIndividualAnalysis(),
            ),
            Container(
              padding: const EdgeInsets.only(left: 200, right: 200),
              width: size.width - 400,
              height: 300,
              child: const Card(child: _ListSectionsIndividual()),
            ),
          ],
        ),
      ),
    );
  }
}

class PageIndividualAnalysis extends StatelessWidget {
  const PageIndividualAnalysis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<IndividualAnalysisController>();
    var individualAnalysis = controller.individualAnalysisModel;

    return controller.state == IndividualAnalysisState.loading
        ? CommonWidgets.loading()
        : Scaffold(
            body: ListView(
              children: [
                const Center(
                  child: Text(
                    "Análise Individual",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return DialogDaysSections(
                          individualAnalysis.sectionsDay,
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
                ),
                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    "Tabela de Sessões",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          );
  }
}

class _ListSectionsIndividual extends StatelessWidget {
  const _ListSectionsIndividual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<IndividualAnalysisController>();
    var individualAnalysis = controller.individualAnalysisModel;
    return CommonWidgets.table(
      [
        "Sessão",
        "Fase",
        "Desempenho",
        "Imagem",
        "Status",
      ],
      List.generate(individualAnalysis.sections?.length ?? 0, (index) {
        return [
          individualAnalysis.sections?[index].section.toString() ?? "",
          individualAnalysis.sections?[index].phase.toString() ?? "",
          individualAnalysis.sections?[index].performance.toString() ?? "",
          individualAnalysis.sections?[index].image.toString() ?? "",
          individualAnalysis.sections?[index].status.toString() ?? "",
        ];
      }),
    );
  }
}
