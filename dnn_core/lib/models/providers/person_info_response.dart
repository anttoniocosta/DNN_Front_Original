class AccountByDocumentResponse {
  String? message;
  int? count;
  ProviderModel? providerModel;

  AccountByDocumentResponse({this.message, this.count, this.providerModel});

  AccountByDocumentResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    count = json['count'];
    providerModel =
        json['data'] != null ? new ProviderModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.providerModel != null) {
      data['data'] = this.providerModel!.toJson();
    }
    return data;
  }
}

class ProviderModel {
  String? document;
  String? name;
  String? gender;
  String? birthDate;
  String? registrationID;
  int? maritalStatus;
  List<String>? phoneNumbers;
  List<String>? emails;
  List<Addresses>? addresses;
  bool? hasPhone;
  bool? hasManyPhone;
  bool? hasEmail;
  bool? hasManyEmail;
  bool? hasAddresses;
  bool? hasManyAddresses;

  ProviderModel(
      {this.document,
      this.name,
      this.gender,
      this.birthDate,
      this.phoneNumbers,
      this.emails,
      this.addresses,
      this.registrationID,
      this.maritalStatus,
      this.hasPhone,
      this.hasManyPhone,
      this.hasEmail,
      this.hasManyEmail,
      this.hasAddresses,
      this.hasManyAddresses});

  ProviderModel.fromJson(Map<String, dynamic> json) {
    document = json['document'];
    name = json['name'];
    gender = json['gender'];
    birthDate = json['birthDate'];
    registrationID = json['registrationID'];
    maritalStatus = json['maritalStatus'];
    phoneNumbers = json['phoneNumbers'].cast<String>();
    emails = json['emails'].cast<String>();
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses.fromJson(v));
      });
    }
    hasPhone = json['hasPhone'];
    hasManyPhone = json['hasManyPhone'];
    hasEmail = json['hasEmail'];
    hasManyEmail = json['hasManyEmail'];
    hasAddresses = json['hasAddresses'];
    hasManyAddresses = json['hasManyAddresses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document'] = this.document;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['birthDate'] = this.birthDate;
    data['phoneNumbers'] = this.phoneNumbers;
    data['registrationID'] = this.registrationID;
    data['maritalStatus'] = this.maritalStatus;
    data['emails'] = this.emails;
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    data['hasPhone'] = this.hasPhone;
    data['hasManyPhone'] = this.hasManyPhone;
    data['hasEmail'] = this.hasEmail;
    data['hasManyEmail'] = this.hasManyEmail;
    data['hasAddresses'] = this.hasAddresses;
    data['hasManyAddresses'] = this.hasManyAddresses;
    return data;
  }
}

class Addresses {
  String? zipCode;
  String? addresses;
  String? number;
  String? complement;
  String? neighborhood;
  String? city;
  String? state;

  Addresses(
      {this.zipCode,
      this.addresses,
      this.number,
      this.complement,
      this.neighborhood,
      this.city,
      this.state});

  Addresses.fromJson(Map<String, dynamic> json) {
    zipCode = json['zipCode'];
    addresses = json['addresses'];
    number = json['number'];
    complement = json['complement'];
    neighborhood = json['neighborhood'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zipCode'] = this.zipCode;
    data['addresses'] = this.addresses;
    data['number'] = this.number;
    data['complement'] = this.complement;
    data['neighborhood'] = this.neighborhood;
    data['city'] = this.city;
    data['state'] = this.state;
    return data;
  }
}
