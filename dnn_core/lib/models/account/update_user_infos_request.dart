class UpdateUserInfosRequest {
  String? id;
  String? fullName;
  String? document;
  String? email;
  String? birthday;
  String? phoneNumber;
  String? pixKey;
  String? zipcode;
  String? address;
  String? gender;
  String? city;
  String? state;
  String? number;
  String? complement;
  String? neighborhood;
  String? ibge;
  String? registrationID;
  int? maritalStatus;

  UpdateUserInfosRequest({
    this.id,
    this.fullName,
    this.document,
    this.email,
    this.birthday,
    this.phoneNumber,
    this.pixKey,
    this.zipcode,
    this.address,
    this.gender,
    this.city,
    this.state,
    this.number,
    this.complement,
    this.neighborhood,
    this.ibge,
    this.registrationID,
    this.maritalStatus,
  });

  UpdateUserInfosRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    document = json['document'];
    email = json['email'];
    birthday = json['birthday'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    pixKey = json['pixKey'];
    zipcode = json['zipcode'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    number = json['number'];
    complement = json['complement'];
    neighborhood = json['neighborhood'];
    ibge = json['ibge'];
    registrationID = json['registrationID'];
    maritalStatus = json['maritalStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['document'] = this.document;
    data['email'] = this.email;
    data['birthday'] = this.birthday;
    data['gender'] = this.gender;
    data['phoneNumber'] = this.phoneNumber;
    data['pixKey'] = this.pixKey;
    data['zipcode'] = this.zipcode;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['number'] = this.number;
    data['complement'] = this.complement;
    data['neighborhood'] = this.neighborhood;
    data['ibge'] = this.ibge;
    data['registrationID'] = this.registrationID;
    data['maritalStatus'] = this.maritalStatus;
    return data;
  }
}
