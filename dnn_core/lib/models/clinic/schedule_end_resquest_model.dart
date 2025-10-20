class ScheduledEndRequestModel {
  String? scheduleServicesId;
  String? miniMedicalRecord;

  ScheduledEndRequestModel({this.scheduleServicesId, this.miniMedicalRecord});

  ScheduledEndRequestModel.fromJson(Map<String, dynamic> json) {
    scheduleServicesId = json['scheduleServicesId'];
    miniMedicalRecord = json['miniMedicalRecord'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheduleServicesId'] = this.scheduleServicesId;
    data['miniMedicalRecord'] = this.miniMedicalRecord;
    return data;
  }
}

class ScheduledTriagemEndRequestModel {
  String? screeningId;
  String? mainComplaint;
  String? medicalHistory;
  String? currentMedication;

  ScheduledTriagemEndRequestModel({
    this.screeningId,
    this.mainComplaint,
    this.medicalHistory,
    this.currentMedication,
  });

  ScheduledTriagemEndRequestModel.fromJson(Map<String, dynamic> json) {
    screeningId = json['screeningId'];
    mainComplaint = json['mainComplaint'];
    medicalHistory = json['medicalHistory'];
    currentMedication = json['currentMedication'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['screeningId'] = this.screeningId;
    data['mainComplaint'] = this.mainComplaint;
    data['medicalHistory'] = this.medicalHistory;
    data['currentMedication'] = this.currentMedication;
    return data;
  }
}
