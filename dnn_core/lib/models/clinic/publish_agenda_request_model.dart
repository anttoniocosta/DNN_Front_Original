class PublishAgendaRequestModel {
  String? clinicSpecialistId;
  List<String>? dates;
  bool? isAcceptsDnnPlan;
  bool? isReadyService;
  double? price;
  int? typeScheduleId;
  List<PublishHours>? hours;

  PublishAgendaRequestModel({
    this.clinicSpecialistId,
    this.dates,
    this.hours,
    this.isAcceptsDnnPlan,
    this.isReadyService,
    this.price,
    this.typeScheduleId,
  });

  PublishAgendaRequestModel.fromJson(Map<String, dynamic> json) {
    clinicSpecialistId = json['clinicSpecialistId'];
    isReadyService = json['isReadyService'];
    isAcceptsDnnPlan = json['isAcceptsDnnPlan'];
    price = json['price'];
    typeScheduleId = json['typeScheduleId'];
    dates = json['dates'].cast<String>();
    if (json['hours'] != null) {
      hours = <PublishHours>[];
      json['hours'].forEach((v) {
        hours!.add(new PublishHours.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clinicSpecialistId'] = this.clinicSpecialistId;
    data['isReadyService'] = this.isReadyService;
    data['isAcceptsDnnPlan'] = this.isAcceptsDnnPlan;
    data['price'] = this.price;
    data['typeScheduleId'] = this.typeScheduleId;
    data['dates'] = this.dates;
    if (this.hours != null) {
      data['hours'] = this.hours!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PublishHours {
  String? hour;
  int? typeScheduleId;
  double? price;

  PublishHours({this.hour, this.typeScheduleId, this.price});

  PublishHours.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    typeScheduleId = json['typeScheduleId'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hour'] = this.hour;
    data['typeScheduleId'] = this.typeScheduleId;
    data['price'] = this.price;
    return data;
  }
}
