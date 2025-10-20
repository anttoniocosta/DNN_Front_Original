class SpecialistResponseModel {
  String? id;
  ClinicResponseModel? clinic;
  DoctorResponseModel? doctor;
  int? specialtyId;
  String? specialtyName;
  double? price;

  SpecialistResponseModel(
      {this.id,
      this.clinic,
      this.doctor,
      this.specialtyId,
      this.specialtyName,
      this.price});

  SpecialistResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clinic = json['clinic'] != null
        ? new ClinicResponseModel.fromJson(json['clinic'])
        : null;
    doctor = json['doctor'] != null
        ? new DoctorResponseModel.fromJson(json['doctor'])
        : null;
    specialtyId = json['specialtyId'];
    specialtyName = json['specialtyName'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.clinic != null) {
      data['clinic'] = this.clinic!.toJson();
    }
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    data['specialtyId'] = this.specialtyId;
    data['specialtyName'] = this.specialtyName;
    data['price'] = this.price;
    return data;
  }
}

class ClinicResponseModel {
  String? clinicId;
  String? fullName;
  String? document;
  String? email;
  String? phoneNumber;
  String? zipcode;
  String? address;
  String? number;
  String? complement;
  String? neighborhood;
  String? city;
  String? state;
  String? ibge;

  ClinicResponseModel(
      {this.clinicId,
      this.fullName,
      this.document,
      this.email,
      this.phoneNumber,
      this.zipcode,
      this.address,
      this.number,
      this.complement,
      this.neighborhood,
      this.city,
      this.state,
      this.ibge});

  ClinicResponseModel.fromJson(Map<String, dynamic> json) {
    clinicId = json['clinicId'];
    fullName = json['fullName'];
    document = json['document'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    zipcode = json['zipcode'];
    address = json['address'];
    number = json['number'];
    complement = json['complement'];
    neighborhood = json['neighborhood'];
    city = json['city'];
    state = json['state'];
    ibge = json['ibge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clinicId'] = this.clinicId;
    data['fullName'] = this.fullName;
    data['document'] = this.document;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['zipcode'] = this.zipcode;
    data['address'] = this.address;
    data['number'] = this.number;
    data['complement'] = this.complement;
    data['neighborhood'] = this.neighborhood;
    data['city'] = this.city;
    data['state'] = this.state;
    data['ibge'] = this.ibge;
    return data;
  }
}

class DoctorResponseModel {
  String? doctorId;
  String? fullName;
  String? document;
  String? email;
  String? birthday;
  String? phoneNumber;
  String? zipcode;
  String? address;
  String? number;
  String? complement;
  String? neighborhood;
  String? city;
  String? state;
  String? ibge;
  String? gender;
  String? registrationID;
  int? maritalStatus;
  String? crmNumber;

  DoctorResponseModel(
      {this.doctorId,
      this.fullName,
      this.document,
      this.email,
      this.birthday,
      this.phoneNumber,
      this.zipcode,
      this.address,
      this.number,
      this.complement,
      this.neighborhood,
      this.city,
      this.state,
      this.ibge,
      this.gender,
      this.registrationID,
      this.maritalStatus,
      this.crmNumber});

  DoctorResponseModel.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctorId'];
    fullName = json['fullName'];
    document = json['document'];
    email = json['email'];
    birthday = json['birthday'];
    phoneNumber = json['phoneNumber'];
    zipcode = json['zipcode'];
    address = json['address'];
    number = json['number'];
    complement = json['complement'];
    neighborhood = json['neighborhood'];
    city = json['city'];
    state = json['state'];
    ibge = json['ibge'];
    gender = json['gender'];
    registrationID = json['registrationID'];
    maritalStatus = json['maritalStatus'];
    crmNumber = json['crmNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctorId'] = this.doctorId;
    data['fullName'] = this.fullName;
    data['document'] = this.document;
    data['email'] = this.email;
    data['birthday'] = this.birthday;
    data['phoneNumber'] = this.phoneNumber;
    data['zipcode'] = this.zipcode;
    data['address'] = this.address;
    data['number'] = this.number;
    data['complement'] = this.complement;
    data['neighborhood'] = this.neighborhood;
    data['city'] = this.city;
    data['state'] = this.state;
    data['ibge'] = this.ibge;
    data['gender'] = this.gender;
    data['registrationID'] = this.registrationID;
    data['maritalStatus'] = this.maritalStatus;
    data['crmNumber'] = this.crmNumber;
    return data;
  }
}
