import 'package:flutter/cupertino.dart';
import 'package:glboard_web/src/constants.dart';
import 'package:glboard_web/src/features/general_analysis/models/general_analysis_model.dart';
import 'package:glboard_web/src/shared/service_http.dart';
import 'package:glboard_web/src/shared/structs.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

enum GeneralAnalysisState { idle, success, error, loading }

class GeneralAnalysisController extends ChangeNotifier {
  var state = GeneralAnalysisState.idle;

  final ClientHttp clientHttp;

  String error = "";

  var generalAnalysisModel = GeneralAnalysisModel();

  GeneralAnalysisController(this.clientHttp);

  Future<void> fetchGeneralAnalysis(String gameID) async {
    state = GeneralAnalysisState.loading;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    String url = "$urlbackend/data_analysis";

    try {
      var result = await clientHttp.get(url, {"game_id": gameID});
      generalAnalysisModel = GeneralAnalysisModel.fromJson(result);

      // final shared = await SharedPreferences.getInstance();
      // await shared.setString('GeneralDataAnalysis');
      state = GeneralAnalysisState.success;
      notifyListeners();
      state = GeneralAnalysisState.idle;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      state = GeneralAnalysisState.error;
      notifyListeners();
      state = GeneralAnalysisState.idle;
      notifyListeners();
    }
  }

  List<ColumnSeries<ChartData, String>> avaragePerfomancePhaseDataChart() {
    final List<ChartData> chartData = [];

    int sizeArray =
        generalAnalysisModel.averagePerfomacePhaseTotal?.length ?? 0;

    for (int i = 0; i < sizeArray; i++) {
      chartData.add(
        ChartData(
          generalAnalysisModel.averagePerfomacePhaseTotal![i].phase,
          generalAnalysisModel.averagePerfomacePhaseTotal![i].averagePhase,
        ),
      );
    }
    return _columnSeries(chartData);
  }

  List<ColumnSeries<ChartData, String>> attemptsPhaseDataChart() {
    final List<ChartData> chartData = [];

    int sizeArray = generalAnalysisModel.attemptsPhaseTotal?.length ?? 0;

    for (int i = 0; i < sizeArray; i++) {
      chartData.add(
        ChartData(
          generalAnalysisModel.attemptsPhaseTotal![i].phase,
          generalAnalysisModel.attemptsPhaseTotal![i].attemptPhase.toDouble(),
        ),
      );
    }
    return _columnSeries(chartData);
  }

  List<ColumnSeries<ChartData, String>> conclusionPhaseDataChart() {
    final List<ChartData> chartData = [];

    int sizeArray = generalAnalysisModel.quantPlayerFinalizedPhase?.length ?? 0;

    for (int i = 0; i < sizeArray; i++) {
      chartData.add(
        ChartData(
          generalAnalysisModel.quantPlayerFinalizedPhase![i].phase,
          generalAnalysisModel.quantPlayerFinalizedPhase![i].quantConclusion
              .toDouble(),
        ),
      );
    }
    return _columnSeries(chartData);
  }

  List<ColumnSeries<ChartData, String>> timeInPhaseDataChart() {
    final List<ChartData> chartData = [];

    int sizeArray = generalAnalysisModel.timePlayedPhaseTotal?.length ?? 0;

    for (int i = 0; i < sizeArray; i++) {
      chartData.add(
        ChartData(
          generalAnalysisModel.timePlayedPhaseTotal![i].phase,
          generalAnalysisModel.timePlayedPhaseTotal![i].timePhaseMinutes
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
