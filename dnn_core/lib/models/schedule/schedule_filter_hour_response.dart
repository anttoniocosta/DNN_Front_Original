class ScheduleFilterHourResponse {
  String? id;
  String? clinicId;
  String? clinicName;
  String? clinicPhoneNumber;
  String? clinicPhoto;
  String? clinicZipcode;
  String? clinicAddress;
  String? clinicCity;
  String? clinicState;
  String? clinicNumber;
  String? clinicComplement;
  String? clinicNeighborhood;
  bool? isOperator;
  String? specialistId;
  String? specialistName;
  String? crmNumber;
  bool? isReadyService;
  bool? isAcceptsDnnPlan;
  double? price;
  int? typeScheduleId;
  String? typeScheduleName;
  String? dateSchedule;
  int? specialtyId;
  String? specialtyName;

  ScheduleFilterHourResponse(
      {this.id,
      this.clinicId,
      this.clinicName,
      this.clinicPhoneNumber,
      this.clinicPhoto,
      this.clinicZipcode,
      this.clinicAddress,
      this.clinicCity,
      this.clinicState,
      this.clinicNumber,
      this.clinicComplement,
      this.clinicNeighborhood,
      this.isOperator,
      this.specialistId,
      this.specialistName,
      this.crmNumber,
      this.isReadyService,
      this.isAcceptsDnnPlan,
      this.price,
      this.typeScheduleId,
      this.typeScheduleName,
      this.dateSchedule,
      this.specialtyId,
      this.specialtyName});

  ScheduleFilterHourResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clinicId = json['clinicId'];
    clinicName = json['clinicName'];
    clinicPhoneNumber = json['clinicPhoneNumber'];
    clinicPhoto = json['clinicPhoto'];
    clinicZipcode = json['clinicZipcode'];
    clinicAddress = json['clinicAddress'];
    clinicCity = json['clinicCity'];
    clinicState = json['clinicState'];
    clinicNumber = json['clinicNumber'];
    clinicComplement = json['clinicComplement'];
    clinicNeighborhood = json['clinicNeighborhood'];
    isOperator = json['isOperator'];
    specialistId = json['specialistId'];
    specialistName = json['specialistName'];
    crmNumber = json['crmNumber'];
    isReadyService = json['isReadyService'];
    isAcceptsDnnPlan = json['isAcceptsDnnPlan'];
    price = json['price'];
    typeScheduleId = json['typeScheduleId'];
    typeScheduleName = json['typeScheduleName'];
    dateSchedule = json['dateSchedule'];
    specialtyId = json['specialtyId'];
    specialtyName = json['specialtyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['clinicId'] = this.clinicId;
    data['clinicName'] = this.clinicName;
    data['clinicPhoneNumber'] = this.clinicPhoneNumber;
    data['clinicPhoto'] = this.clinicPhoto;
    data['clinicZipcode'] = this.clinicZipcode;
    data['clinicAddress'] = this.clinicAddress;
    data['clinicCity'] = this.clinicCity;
    data['clinicState'] = this.clinicState;
    data['clinicNumber'] = this.clinicNumber;
    data['clinicComplement'] = this.clinicComplement;
    data['clinicNeighborhood'] = this.clinicNeighborhood;
    data['isOperator'] = this.isOperator;
    data['specialistId'] = this.specialistId;
    data['specialistName'] = this.specialistName;
    data['crmNumber'] = this.crmNumber;
    data['isReadyService'] = this.isReadyService;
    data['isAcceptsDnnPlan'] = this.isAcceptsDnnPlan;
    data['price'] = this.price;
    data['typeScheduleId'] = this.typeScheduleId;
    data['typeScheduleName'] = this.typeScheduleName;
    data['dateSchedule'] = this.dateSchedule;
    data['specialtyId'] = this.specialtyId;
    data['specialtyName'] = this.specialtyName;
    return data;
  }
}
