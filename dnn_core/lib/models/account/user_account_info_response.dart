// ignore_for_file: public_member_api_docs, sort_constructors_first
class AccountDetailsResponse {
  String? message;
  UserAccountInfoModel? data;

  AccountDetailsResponse({this.message, this.data});

  AccountDetailsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? new UserAccountInfoModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserAccountInfoModel {
  String? id;
  String? fullName;
  String? shortName;
  String? document;
  String? email;
  String? birthday;
  String? phoneNumber;
  bool? phoneNumberConfirmed;
  String? pixKey;
  String? photo;
  String? zipcode;
  String? address;
  String? city;
  String? state;
  String? number;
  String? complement;
  String? neighborhood;
  String? ibge;
  String? externalUid;
  String? gender;
  String? registrationID;
  int? maritalStatus;
  User? user;
  bool? needChoiceInstance;
  List<InstancesModel>? instances;

  UserAccountInfoModel(
      {this.id,
      this.fullName,
      this.shortName,
      this.document,
      this.email,
      this.birthday,
      this.phoneNumber,
      this.phoneNumberConfirmed,
      this.pixKey,
      this.photo,
      this.zipcode,
      this.address,
      this.city,
      this.state,
      this.number,
      this.complement,
      this.neighborhood,
      this.ibge,
      this.externalUid,
      this.gender,
      this.registrationID,
      this.maritalStatus,
      this.user,
      this.needChoiceInstance,
      this.instances});

  UserAccountInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    shortName = json['shortName'];
    document = json['document'];
    email = json['email'];
    birthday = json['birthday'];
    phoneNumber = json['phoneNumber'];
    phoneNumberConfirmed = json['phoneNumberConfirmed'];
    pixKey = json['pixKey'];
    photo = json['photo'];
    zipcode = json['zipcode'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    number = json['number'];
    complement = json['complement'];
    neighborhood = json['neighborhood'];
    ibge = json['ibge'];
    externalUid = json['externalUid'];
    gender = json['gender'];
    registrationID = json['registrationID'];
    maritalStatus = json['maritalStatus'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    needChoiceInstance = json['needChoiceInstance'];
    if (json['instances'] != null) {
      instances = <InstancesModel>[];
      json['instances'].forEach((v) {
        instances!.add(new InstancesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['shortName'] = this.shortName;
    data['document'] = this.document;
    data['email'] = this.email;
    data['birthday'] = this.birthday;
    data['phoneNumber'] = this.phoneNumber;
    data['phoneNumberConfirmed'] = this.phoneNumberConfirmed;
    data['pixKey'] = this.pixKey;
    data['photo'] = this.photo;
    data['zipcode'] = this.zipcode;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['number'] = this.number;
    data['complement'] = this.complement;
    data['neighborhood'] = this.neighborhood;
    data['ibge'] = this.ibge;
    data['externalUid'] = this.externalUid;
    data['gender'] = this.gender;
    data['registrationID'] = this.registrationID;
    data['maritalStatus'] = this.maritalStatus;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['needChoiceInstance'] = this.needChoiceInstance;
    if (this.instances != null) {
      data['instances'] = this.instances!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? login;
  String? email;
  bool? emailConfirmed;
  String? roleName;

  User(
      {this.id,
      this.name,
      this.login,
      this.email,
      this.emailConfirmed,
      this.roleName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    login = json['login'];
    email = json['email'];
    emailConfirmed = json['emailConfirmed'];
    roleName = json['roleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['login'] = this.login;
    data['email'] = this.email;
    data['emailConfirmed'] = this.emailConfirmed;
    data['roleName'] = this.roleName;
    return data;
  }
}

class UserModel {
  String? id;
  String? name;
  String? login;
  String? email;
  bool? emailConfirmed;
  String? roleName;

  UserModel(
      {this.id,
      this.name,
      this.login,
      this.email,
      this.emailConfirmed,
      this.roleName});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    login = json['login'];
    email = json['email'];
    emailConfirmed = json['emailConfirmed'];
    roleName = json['roleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['login'] = this.login;
    data['email'] = this.email;
    data['emailConfirmed'] = this.emailConfirmed;
    data['roleName'] = this.roleName;
    return data;
  }
}

class InstancesModel {
  String? instanceId;
  String? instanceName;
  int? contextId;
  String? contextCode;

  InstancesModel(
      {this.instanceId, this.instanceName, this.contextId, this.contextCode});

  InstancesModel.fromJson(Map<String, dynamic> json) {
    instanceId = json['instanceId'];
    instanceName = json['instanceName'];
    contextId = json['contextId'];
    contextCode = json['contextCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instanceId'] = this.instanceId;
    data['instanceName'] = this.instanceName;
    data['contextId'] = this.contextId;
    data['contextCode'] = this.contextCode;
    return data;
  }
}

class InstancesRequestModel {
  String? instance;
  String? context;

  InstancesRequestModel({this.instance, this.context});

  InstancesRequestModel.fromJson(Map<String, dynamic> json) {
    instance = json['instance'];
    context = json['context'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instance'] = this.instance;
    data['context'] = this.context;

    return data;
  }
}
