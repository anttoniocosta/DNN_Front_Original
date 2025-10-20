class ReschedulePutModel {
  String? scheduleConsultationCurrentId;
  String? scheduleConsultationNewId;

  ReschedulePutModel({
    this.scheduleConsultationCurrentId,
    this.scheduleConsultationNewId,
  });

  ReschedulePutModel.fromJson(Map<String, dynamic> json) {
    scheduleConsultationCurrentId = json['scheduleConsultationCurrentId'];
    scheduleConsultationNewId = json['scheduleConsultationNewId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheduleConsultationCurrentId'] = this.scheduleConsultationCurrentId;
    data['scheduleConsultationNewId'] = this.scheduleConsultationNewId;
    return data;
  }
}
