import 'package:flutter/cupertino.dart';
import 'package:glboard_web/src/constants.dart';
import 'package:glboard_web/src/features/individual_analysis/models/individual_analysis_model.dart';
import 'package:glboard_web/src/shared/service_http.dart';
import 'package:glboard_web/src/shared/structs.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

enum IndividualAnalysisState { idle, success, error, loading }

class IndividualAnalysisController extends ChangeNotifier {
  var state = IndividualAnalysisState.idle;

  final ClientHttp clientHttp;

  String error = "";

  var individualAnalysisModel = IndividualAnalysisModel();

  IndividualAnalysisController(this.clientHttp);

  Future<void> fetchIndividualAnalysis(String gameUserId) async {
    state = IndividualAnalysisState.loading;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    String url = "${urlbackend}/user_analysis";

    try {
      var result = await clientHttp.get(url, {"game_user_id": gameUserId});
      individualAnalysisModel = IndividualAnalysisModel.fromJson(result);

      // final shared = await SharedPreferences.getInstance();
      // await shared.setString('GeneralDataAnalysis');
      state = IndividualAnalysisState.success;
      notifyListeners();
      state = IndividualAnalysisState.idle;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      state = IndividualAnalysisState.error;
      notifyListeners();
      state = IndividualAnalysisState.idle;
      notifyListeners();
    }
  }

  List<ColumnSeries<ChartData, String>> avaragePerfomancePhaseDataChart() {
    final List<ChartData> chartData = [];

    int sizeArray =
        individualAnalysisModel.averagePerfomacePhaseTotal?.length ?? 0;

    for (int i = 0; i < sizeArray; i++) {
      chartData.add(
        ChartData(
          individualAnalysisModel.averagePerfomacePhaseTotal![i].phase,
          individualAnalysisModel.averagePerfomacePhaseTotal![i].averagePhase
              .toDouble(),
        ),
      );
    }
    return _columnSeries(chartData);
  }

  List<ColumnSeries<ChartData, String>> attemptsPhaseDataChart() {
    final List<ChartData> chartData = [];

    int sizeArray = individualAnalysisModel.attemptsPhaseTotal?.length ?? 0;

    for (int i = 0; i < sizeArray; i++) {
      chartData.add(
        ChartData(
          individualAnalysisModel.attemptsPhaseTotal![i].phase,
          individualAnalysisModel.attemptsPhaseTotal![i].attemptPhase
              .toDouble(),
        ),
      );
    }
    return _columnSeries(chartData);
  }

  List<ColumnSeries<ChartData, String>> conclusionPhaseDataChart() {
    final List<ChartData> chartData = [];

    int sizeArray =
        individualAnalysisModel.quantPlayerFinalizedPhase?.length ?? 0;

    for (int i = 0; i < sizeArray; i++) {
      chartData.add(
        ChartData(
          individualAnalysisModel.quantPlayerFinalizedPhase![i].phase,
          individualAnalysisModel.quantPlayerFinalizedPhase![i].quantConclusion
              .toDouble(),
        ),
      );
    }
    return _columnSeries(chartData);
  }

  List<ColumnSeries<ChartData, String>> timeInPhaseDataChart() {
    final List<ChartData> chartData = [];

    int sizeArray = individualAnalysisModel.timePlayedPhaseTotal?.length ?? 0;

    for (int i = 0; i < sizeArray; i++) {
      chartData.add(
        ChartData(
          individualAnalysisModel.timePlayedPhaseTotal![i].phase,
          individualAnalysisModel.timePlayedPhaseTotal![i].timePhaseMinutes
              .toDouble(),
        ),
      );
    }
    return _columnSeries(chartData);
  }

  List<ColumnSeries<ChartData, String>> _columnSeries(List<ChartData> data) {
    return <ColumnSeries<ChartData, String>>[
      ColumnSeries<ChartData, String>(
        dataSource: data,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }
}
