class PublishAgendaCheckModel {
  String? clinicSpecialistId;
  List<String>? dates;
  bool? isReadyService;
  bool? isAcceptsDnnPlan;
  String? hour;
  int? typeScheduleId;

  PublishAgendaCheckModel(
      {this.clinicSpecialistId,
      this.dates,
      this.isReadyService,
      this.isAcceptsDnnPlan,
      this.hour,
      this.typeScheduleId});

  PublishAgendaCheckModel.fromJson(Map<String, dynamic> json) {
    clinicSpecialistId = json['clinicSpecialistId'];
    dates = json['dates'].cast<String>();
    isReadyService = json['isReadyService'];
    isAcceptsDnnPlan = json['isAcceptsDnnPlan'];
    hour = json['hour'];
    typeScheduleId = json['typeScheduleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clinicSpecialistId'] = this.clinicSpecialistId;
    data['dates'] = this.dates;
    data['isReadyService'] = this.isReadyService;
    data['isAcceptsDnnPlan'] = this.isAcceptsDnnPlan;
    data['hour'] = this.hour;
    data['typeScheduleId'] = this.typeScheduleId;
    return data;
  }
}
