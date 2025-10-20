// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dnn_core/all_exports.dart';

class CreateSpecialistParams {
  String? id;
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
  int? specialtyId;
  double? price;

  CreateSpecialistParams(
      {this.id,
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
      this.crmNumber,
      this.specialtyId,
      this.price});

  CreateSpecialistParams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    specialtyId = json['specialtyId'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['specialtyId'] = this.specialtyId;
    data['price'] = this.price;
    return data;
  }

  factory CreateSpecialistParams.adapterForRegister(
      {required AccountRequestModel model,
      required double price,
      required int specialtyId,
      required String crmNumber}) {
    return CreateSpecialistParams(
      id: null,
      fullName: model.name,
      document: model.document,
      email: model.email,
      birthday: model.birthday,
      phoneNumber: model.phoneNumber,
      zipcode: model.address!.zipcode,
      address: model.address!.street,
      number: model.address!.number,
      complement: model.address!.complement,
      neighborhood: model.address!.neighborhood,
      city: model.address!.city,
      state: model.address!.state,
      ibge: model.address!.ibge,
      gender: model.gender,
      registrationID: model.registrationID,
      maritalStatus: model.maritalStatus,
      crmNumber: crmNumber,
      specialtyId: specialtyId,
      price: price,
    );
  }

  @override
  String toString() {
    return 'CreateSpecialistParams(id: $id, fullName: $fullName, document: $document, email: $email, birthday: $birthday, phoneNumber: $phoneNumber, zipcode: $zipcode, address: $address, number: $number, complement: $complement, neighborhood: $neighborhood, city: $city, state: $state, ibge: $ibge, gender: $gender, registrationID: $registrationID, maritalStatus: $maritalStatus, crmNumber: $crmNumber, specialtyId: $specialtyId,  price: $price)';
  }
}
