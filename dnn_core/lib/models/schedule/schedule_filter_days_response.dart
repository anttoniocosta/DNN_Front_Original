class ScheduleFilterDaysResponse {
  int? specialtyId;
  String? specialtyName;
  bool? isReadyService;
  bool? isAcceptsDnnPlan;
  String? dateSchedule;
  double? price;

  ScheduleFilterDaysResponse(
      {this.specialtyId,
      this.specialtyName,
      this.isReadyService,
      this.isAcceptsDnnPlan,
      this.dateSchedule,
      this.price});

  ScheduleFilterDaysResponse.fromJson(Map<String, dynamic> json) {
    specialtyId = json['specialtyId'];
    specialtyName = json['specialtyName'];
    isReadyService = json['isReadyService'];
    isAcceptsDnnPlan = json['isAcceptsDnnPlan'];
    dateSchedule = json['dateSchedule'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['specialtyId'] = this.specialtyId;
    data['specialtyName'] = this.specialtyName;
    data['isReadyService'] = this.isReadyService;
    data['isAcceptsDnnPlan'] = this.isAcceptsDnnPlan;
    data['dateSchedule'] = this.dateSchedule;
    data['price'] = this.price;
    return data;
  }
}
