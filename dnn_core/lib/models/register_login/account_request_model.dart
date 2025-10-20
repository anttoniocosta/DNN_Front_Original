// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../all_exports.dart';

class AccountRequestModel {
  String? document;
  String? name;
  String? birthday;
  String? email;
  String? phoneNumber;
  String? gender;
  String? firebaseToken;
  String? contractId;
  String? registrationID;
  int? maritalStatus;
  AddressModel? address;

  AccountRequestModel(
      {this.document,
      this.name,
      this.birthday,
      this.email,
      this.phoneNumber,
      this.gender,
      this.firebaseToken,
      this.address,
      this.maritalStatus,
      this.registrationID,
      this.contractId});

  AccountRequestModel.fromJson(Map<String, dynamic> json) {
    document = json['document'];
    name = json['name'];
    birthday = json['birthday'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    contractId = json['contractId'];
    firebaseToken = json['firebaseToken'];
    maritalStatus = json['maritalStatus'];
    registrationID = json['registrationID'];
    address = json['address'] != null
        ? new AddressModel.fromJson(json['address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document'] = this.document;
    data['name'] = this.name;
    data['birthday'] = this.birthday;
    data['email'] = this.email;
    data['maritalStatus'] = this.maritalStatus;
    data['registrationID'] = this.registrationID;
    data['phoneNumber'] = this.phoneNumber;
    data['gender'] = this.gender;
    if (this.contractId != null) {
      data['contractId'] = this.contractId;
    }
    data['firebaseToken'] = this.firebaseToken;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}
