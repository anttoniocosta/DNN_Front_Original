import 'package:dnn_core/models/export.dart';

class RescheduleResponseModel {
  String? scheduleConsultationId;
  String? currentDate;
  double? price;
  String? typeSchedule;
  MyAppoitmentDoctorModel? doctor;
  MyAppoitmentPersonModel? clinic;
  MyAppoitmentPersonModel? patient;
  List<RescheduleDates>? dates;

  RescheduleResponseModel(
      {this.scheduleConsultationId,
      this.currentDate,
      this.price,
      this.typeSchedule,
      this.doctor,
      this.clinic,
      this.patient,
      this.dates});

  RescheduleResponseModel.fromJson(Map<String, dynamic> json) {
    scheduleConsultationId = json['scheduleConsultationId'];
    currentDate = json['currentDate'];
    price = json['price'];
    typeSchedule = json['typeSchedule'];
    doctor = json['doctor'] != null
        ? new MyAppoitmentDoctorModel.fromJson(json['doctor'])
        : null;
    clinic = json['clinic'] != null
        ? new MyAppoitmentPersonModel.fromJson(json['clinic'])
        : null;
    patient = json['patient'] != null
        ? new MyAppoitmentPersonModel.fromJson(json['patient'])
        : null;
    if (json['dates'] != null) {
      dates = <RescheduleDates>[];
      json['dates'].forEach((v) {
        dates!.add(new RescheduleDates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheduleConsultationId'] = this.scheduleConsultationId;
    data['currentDate'] = this.currentDate;
    data['price'] = this.price;
    data['typeSchedule'] = this.typeSchedule;
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    if (this.clinic != null) {
      data['clinic'] = this.clinic!.toJson();
    }
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    if (this.dates != null) {
      data['dates'] = this.dates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RescheduleDates {
  String? date;
  List<RescheduleHours>? hours;

  RescheduleDates({this.date, this.hours});

  RescheduleDates.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['hours'] != null) {
      hours = <RescheduleHours>[];
      json['hours'].forEach((v) {
        hours!.add(new RescheduleHours.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.hours != null) {
      data['hours'] = this.hours!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RescheduleHours {
  String? scheduleConsultationNewId;
  String? hour;
  double? price;
  int? typeScheduleId;
  String? typeScheduleName;
  bool? canDelete;

  RescheduleHours(
      {this.scheduleConsultationNewId,
      this.hour,
      this.price,
      this.typeScheduleId,
      this.typeScheduleName,
      this.canDelete});

  RescheduleHours.fromJson(Map<String, dynamic> json) {
    scheduleConsultationNewId = json['scheduleConsultationNewId'];
    hour = json['hour'];
    price = json['price'];
    typeScheduleId = json['typeScheduleId'];
    typeScheduleName = json['typeScheduleName'];
    canDelete = json['canDelete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheduleConsultationNewId'] = this.scheduleConsultationNewId;
    data['hour'] = this.hour;
    data['price'] = this.price;
    data['typeScheduleId'] = this.typeScheduleId;
    data['typeScheduleName'] = this.typeScheduleName;
    data['canDelete'] = this.canDelete;
    return data;
  }
}
