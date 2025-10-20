class QueueResponseModel {
  int? position;
  String? id;
  String? scheduleConsultationId;
  String? clinicId;
  String? specialistId;
  int? specialtyId;
  String? startDate;
  String? endDate;
  String? agoraToken;
  String? mainComplaint;
  String? medicalHistory;
  String? currentMedication;
  String? patientId;
  String? fullName;
  String? document;
  String? email;
  String? photo;
  String? birthday;
  String? gender;
  int? age;

  QueueResponseModel(
      {this.position,
      this.id,
      this.scheduleConsultationId,
      this.clinicId,
      this.specialistId,
      this.specialtyId,
      this.startDate,
      this.endDate,
      this.agoraToken,
      this.mainComplaint,
      this.medicalHistory,
      this.currentMedication,
      this.patientId,
      this.fullName,
      this.document,
      this.email,
      this.photo,
      this.birthday,
      this.gender,
      this.age});

  QueueResponseModel.fromJson(Map<String, dynamic> json) {
    position = json['position'];
    id = json['id'];
    scheduleConsultationId = json['scheduleConsultationId'];
    clinicId = json['clinicId'];
    specialistId = json['specialistId'];
    specialtyId = json['specialtyId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    agoraToken = json['agoraToken'];
    mainComplaint = json['mainComplaint'];
    medicalHistory = json['medicalHistory'];
    currentMedication = json['currentMedication'];
    patientId = json['patientId'];
    fullName = json['fullName'];
    document = json['document'];
    email = json['email'];
    photo = json['photo'];
    birthday = json['birthday'];
    gender = json['gender'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['position'] = this.position;
    data['id'] = this.id;
    data['scheduleConsultationId'] = this.scheduleConsultationId;
    data['clinicId'] = this.clinicId;
    data['specialistId'] = this.specialistId;
    data['specialtyId'] = this.specialtyId;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['agoraToken'] = this.agoraToken;
    data['mainComplaint'] = this.mainComplaint;
    data['medicalHistory'] = this.medicalHistory;
    data['currentMedication'] = this.currentMedication;
    data['patientId'] = this.patientId;
    data['fullName'] = this.fullName;
    data['document'] = this.document;
    data['email'] = this.email;
    data['photo'] = this.photo;
    data['birthday'] = this.birthday;
    data['gender'] = this.gender;
    data['age'] = this.age;
    return data;
  }
}
