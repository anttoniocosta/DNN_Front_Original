class StartScreeningRequestModel {
  String? scheduleConsultationId;
  String? mainComplaint;
  String? medicalHistory;
  String? currentMedication;

  StartScreeningRequestModel(
      {this.scheduleConsultationId,
      this.mainComplaint,
      this.medicalHistory,
      this.currentMedication});

  StartScreeningRequestModel.fromJson(Map<String, dynamic> json) {
    scheduleConsultationId = json['scheduleConsultationId'];
    mainComplaint = json['mainComplaint'];
    medicalHistory = json['medicalHistory'];
    currentMedication = json['currentMedication'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheduleConsultationId'] = this.scheduleConsultationId;
    data['mainComplaint'] = this.mainComplaint;
    data['medicalHistory'] = this.medicalHistory;
    data['currentMedication'] = this.currentMedication;
    return data;
  }
}

class StartStandardRequestModel {
  String? scheduleServiceId;
  String? mainComplaint;
  String? medicalHistory;
  String? currentMedication;

  StartStandardRequestModel(
      {this.scheduleServiceId,
      this.mainComplaint,
      this.medicalHistory,
      this.currentMedication});

  StartStandardRequestModel.fromJson(Map<String, dynamic> json) {
    scheduleServiceId = json['scheduleServiceId'];
    mainComplaint = json['mainComplaint'];
    medicalHistory = json['medicalHistory'];
    currentMedication = json['currentMedication'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheduleServiceId'] = this.scheduleServiceId;
    data['mainComplaint'] = this.mainComplaint;
    data['medicalHistory'] = this.medicalHistory;
    data['currentMedication'] = this.currentMedication;
    return data;
  }
}

class StartScreeningResponseModel {
  String? scheduleConsultationId;
  String? screeningId;
  String? clinicId;
  String? agoraToken;

  StartScreeningResponseModel(
      {this.scheduleConsultationId,
      this.screeningId,
      this.clinicId,
      this.agoraToken});

  StartScreeningResponseModel.fromJson(Map<String, dynamic> json) {
    scheduleConsultationId = json['scheduleConsultationId'];
    screeningId = json['screeningId'];
    clinicId = json['clinicId'];
    agoraToken = json['agoraToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheduleConsultationId'] = this.scheduleConsultationId;
    data['screeningId'] = this.screeningId;
    data['clinicId'] = this.clinicId;
    data['agoraToken'] = this.agoraToken;
    return data;
  }
}
