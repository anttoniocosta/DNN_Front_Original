import '../statics/address_model.dart';

class AddShoppingDependent {
  String? document;
  String? name;
  String? birthday;
  String? email;
  String? phoneNumber;
  String? gender;
  String? registrationID;
  int? maritalStatus;
  AddressModel? address;

  AddShoppingDependent(
      {this.document,
      this.name,
      this.birthday,
      this.email,
      this.phoneNumber,
      this.gender,
      this.registrationID,
      this.maritalStatus,
      this.address});

  AddShoppingDependent.fromJson(Map<String, dynamic> json) {
    document = json['document'];
    name = json['name'];
    birthday = json['birthday'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    registrationID = json['registrationID'];
    maritalStatus = json['maritalStatus'];
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
    data['phoneNumber'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['registrationID'] = this.registrationID;
    data['maritalStatus'] = this.maritalStatus;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}
