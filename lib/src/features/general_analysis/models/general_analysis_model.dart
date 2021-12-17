class GeneralAnalysisModel {
  List<QuantPlayerFinalizedPhase>? quantPlayerFinalizedPhase;
  int quantPlayers = 0;
  Map<String, dynamic> quantPlayersByGener = <String, dynamic>{};
  int quantMinutesInSession = 0;
  Map<String, dynamic> sectionsDay = <String, dynamic>{};
  List<AttemptsPhaseTotal>? attemptsPhaseTotal;
  List<TimePlayedPhaseTotal>? timePlayedPhaseTotal;
  List<DefeatVictoryPhaseTotal>? defeatVictoryPhaseTotal;
  List<AveragePerfomacePhaseTotal>? averagePerfomacePhaseTotal;

  GeneralAnalysisModel(
      {this.quantPlayerFinalizedPhase,
      this.quantPlayers = 0,
      this.quantMinutesInSession = 0,
      this.attemptsPhaseTotal,
      this.timePlayedPhaseTotal,
      this.defeatVictoryPhaseTotal,
      this.averagePerfomacePhaseTotal});

  GeneralAnalysisModel.fromJson(Map<String, dynamic> json) {
    if (json['quant_player_finalized_phase'] != null) {
      quantPlayerFinalizedPhase = [];
      json['quant_player_finalized_phase'].forEach((v) {
        quantPlayerFinalizedPhase?.add(
          QuantPlayerFinalizedPhase.fromJson(v),
        );
      });
    }
    quantPlayers = json['quant_players'];
    sectionsDay = json['sections_day'];
    quantPlayersByGener = json['quant_players_by_gener'];

    quantMinutesInSession = json['quant_minutes_in_session'];

    if (json['attempts_phase_total'] != null) {
      attemptsPhaseTotal = [];
      json['attempts_phase_total'].forEach((v) {
        attemptsPhaseTotal?.add(AttemptsPhaseTotal.fromJson(v));
      });
    }
    if (json['time_played_phase_total'] != null) {
      timePlayedPhaseTotal = [];
      json['time_played_phase_total'].forEach((v) {
        timePlayedPhaseTotal?.add(TimePlayedPhaseTotal.fromJson(v));
      });
    }
    if (json['defeat_victory_phase_total'] != null) {
      defeatVictoryPhaseTotal = [];
      json['defeat_victory_phase_total'].forEach((v) {
        defeatVictoryPhaseTotal?.add(DefeatVictoryPhaseTotal.fromJson(v));
      });
    }
    if (json['average_perfomace_phase_total'] != null) {
      averagePerfomacePhaseTotal = [];
      json['average_perfomace_phase_total'].forEach((v) {
        averagePerfomacePhaseTotal?.add(AveragePerfomacePhaseTotal.fromJson(v));
      });
    }
  }
}

class QuantPlayerFinalizedPhase {
  String phase = "";
  int quantConclusion = 0;

  QuantPlayerFinalizedPhase({this.phase = "", this.quantConclusion = 0});

  QuantPlayerFinalizedPhase.fromJson(Map<String, dynamic> json) {
    phase = json['phase'];
    quantConclusion = json['quant_conclusion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['phase'] = phase;
    data['quant_conclusion'] = quantConclusion;
    return data;
  }
}

class AttemptsPhaseTotal {
  String phase = "";
  int attemptPhase = 0;

  AttemptsPhaseTotal({this.phase = "", this.attemptPhase = 0});

  AttemptsPhaseTotal.fromJson(Map<String, dynamic> json) {
    phase = json['phase'];
    attemptPhase = json['attempt_phase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['phase'] = phase;
    data['attempt_phase'] = attemptPhase;
    return data;
  }
}

class TimePlayedPhaseTotal {
  String phase = "";
  int timePhaseMinutes = 0;

  TimePlayedPhaseTotal({this.phase = "", this.timePhaseMinutes = 0});

  TimePlayedPhaseTotal.fromJson(Map<String, dynamic> json) {
    phase = json['phase'];
    timePhaseMinutes = json['time_phase_minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['phase'] = phase;
    data['time_phase_minutes'] = timePhaseMinutes;
    return data;
  }
}

class DefeatVictoryPhaseTotal {
  String phase = "";
  late Status? status = Status();

  DefeatVictoryPhaseTotal({
    this.phase = "",
    this.status,
  });

  DefeatVictoryPhaseTotal.fromJson(Map<String, dynamic> json) {
    phase = json['phase'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['phase'] = phase;
    if (this.status != null) {
      data['status'] = status?.toJson();
    }
    return data;
  }
}

class Status {
  int dERROTA = 0;
  int vITORIA = 0;
  int dESISTENCIA = 0;

  Status({this.dERROTA = 0, this.vITORIA = 0, this.dESISTENCIA = 0});

  Status.fromJson(Map<String, dynamic> json) {
    dERROTA = json['DERROTA'] ?? 0;
    vITORIA = json['VITORIA'] ?? 0;
    dESISTENCIA = json['DESISTENCIA'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DERROTA'] = this.dERROTA;
    data['VITORIA'] = this.vITORIA;
    data['DESISTENCIA'] = this.dESISTENCIA;
    return data;
  }
}

class AveragePerfomacePhaseTotal {
  String phase = "";
  double averagePhase = 0;

  AveragePerfomacePhaseTotal({this.phase = "", this.averagePhase = 0});

  AveragePerfomacePhaseTotal.fromJson(Map<String, dynamic> json) {
    phase = json['phase'];
    averagePhase = json['average_phase'] ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phase'] = phase;
    data['average_phase'] = averagePhase;
    return data;
  }
}
