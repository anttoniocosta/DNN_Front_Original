class ScreeningQueueModel {
  int? position;
  bool? canOpenAgora;
  int? total;
  String? scheduleServicesId;

  ScreeningQueueModel(
      {this.position, this.canOpenAgora, this.total, this.scheduleServicesId});

  ScreeningQueueModel.fromJson(Map<String, dynamic> json) {
    position = json['position'];
    canOpenAgora = json['canOpenAgora'];
    total = json['total'];
    scheduleServicesId = json['scheduleServicesId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['position'] = this.position;
    data['canOpenAgora'] = this.canOpenAgora;
    data['total'] = this.total;
    data['scheduleServicesId'] = this.scheduleServicesId;
    return data;
  }
}
