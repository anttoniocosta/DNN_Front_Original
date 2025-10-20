class ScheduledDatesResponseModel {
  String? clinicSpecialistId;
  List<ScheduledDates>? dates;

  ScheduledDatesResponseModel({this.clinicSpecialistId, this.dates});

  ScheduledDatesResponseModel.fromJson(Map<String, dynamic> json) {
    clinicSpecialistId = json['clinicSpecialistId'];
    if (json['dates'] != null) {
      dates = <ScheduledDates>[];
      json['dates'].forEach((v) {
        dates!.add(new ScheduledDates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clinicSpecialistId'] = this.clinicSpecialistId;
    if (this.dates != null) {
      data['dates'] = this.dates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScheduledDates {
  String? date;
  List<ScheduledHours>? hours;

  ScheduledDates({this.date, this.hours});

  ScheduledDates.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['hours'] != null) {
      hours = <ScheduledHours>[];
      json['hours'].forEach((v) {
        hours!.add(new ScheduledHours.fromJson(v));
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

class ScheduledHours {
  String? id;
  String? hour;
  double? price;
  int? typeScheduleId;
  String? typeScheduleName;
  bool? canDelete;

  ScheduledHours(
      {this.id,
      this.hour,
      this.price,
      this.typeScheduleId,
      this.typeScheduleName,
      this.canDelete});

  ScheduledHours.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hour = json['hour'];
    price = json['price'];
    typeScheduleId = json['typeScheduleId'];
    typeScheduleName = json['typeScheduleName'];
    canDelete = json['canDelete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hour'] = this.hour;
    data['price'] = this.price;
    data['typeScheduleId'] = this.typeScheduleId;
    data['typeScheduleName'] = this.typeScheduleName;
    data['canDelete'] = this.canDelete;
    return data;
  }
}
