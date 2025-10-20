class ScheduledFinalStatusModel {
  bool? hasStarted;
  bool? hasFinished;
  String? scheduleServicesId;

  ScheduledFinalStatusModel(
      {this.hasStarted, this.hasFinished, this.scheduleServicesId});

  ScheduledFinalStatusModel.fromJson(Map<String, dynamic> json) {
    hasStarted = json['hasStarted'];
    hasFinished = json['hasFinished'];
    scheduleServicesId = json['scheduleServicesId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasStarted'] = this.hasStarted;
    data['hasFinished'] = this.hasFinished;
    data['scheduleServicesId'] = this.scheduleServicesId;
    return data;
  }
}
