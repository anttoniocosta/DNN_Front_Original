import 'package:dnn_core/models/register_login/account_request_model.dart';

class CreateClinicParams {
  String? id;
  String? fullName;
  String? document;
  String? email;
  String? phoneNumber;
  String? photo;
  String? zipcode;
  String? address;
  String? number;
  String? complement;
  String? neighborhood;
  String? city;
  String? state;
  String? ibge;
  String? passwordHash;
  bool? hasScreening;

  CreateClinicParams({
    this.id,
    this.fullName,
    this.document,
    this.email,
    this.phoneNumber,
    this.photo,
    this.zipcode,
    this.address,
    this.number,
    this.complement,
    this.neighborhood,
    this.city,
    this.state,
    this.ibge,
    this.passwordHash,
    this.hasScreening,
  });

  CreateClinicParams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    document = json['document'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    photo = json['photo'];
    zipcode = json['zipcode'];
    address = json['address'];
    number = json['number'];
    complement = json['complement'];
    neighborhood = json['neighborhood'];
    city = json['city'];
    state = json['state'];
    ibge = json['ibge'];
    passwordHash = json['passwordHash'];
    hasScreening = json['hasScreening'];
  }

  CreateClinicParams.fromProvider(AccountRequestModel model)
      : this(
          id: null,
          fullName: model.name,
          document: model.document,
          email: model.email,
          phoneNumber: model.phoneNumber,
          photo: '',
          zipcode: model.address!.zipcode,
          address: model.address!.street,
          number: model.address!.number,
          complement: model.address!.complement,
          neighborhood: model.address!.neighborhood,
          city: model.address!.city,
          state: model.address!.state,
          ibge: model.address!.ibge,
          passwordHash: '',
          hasScreening: false,
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['document'] = this.document;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['photo'] = this.photo;
    data['zipcode'] = this.zipcode;
    data['address'] = this.address;
    data['number'] = this.number;
    data['complement'] = this.complement;
    data['neighborhood'] = this.neighborhood;
    data['city'] = this.city;
    data['state'] = this.state;
    data['ibge'] = this.ibge;
    data['passwordHash'] = this.passwordHash;
    data['hasScreening'] = this.hasScreening;
    return data;
  }
}
