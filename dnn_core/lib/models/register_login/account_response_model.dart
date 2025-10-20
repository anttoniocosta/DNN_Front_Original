class AccountResponseModel {
  String? message;
  AccountResponseData? data;

  AccountResponseModel({this.message, this.data});

  AccountResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? new AccountResponseData.fromJson(json['data'])
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

  @override
  String toString() => 'AccountResponseModel(message: $message, data: $data)';
}

class AccountResponseData {
  String? accessToken;
  String? expiredAt;
  String? fullName;
  String? email;
  String? login;
  String? photo;
  String? codeKey;
  bool? requiredAuthentication;
  bool? needChooseAccess;
  bool? needCompleteData;

  AccountResponseData(
      {this.accessToken,
      this.expiredAt,
      this.fullName,
      this.email,
      this.login,
      this.photo,
      this.needChooseAccess,
      this.needCompleteData,
      this.codeKey,
      this.requiredAuthentication});

  AccountResponseData.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    expiredAt = json['expiredAt'];
    fullName = json['fullName'];
    email = json['email'];
    login = json['login'];
    photo = json['photo'];
    codeKey = json['codeKey'];
    needChooseAccess = json['needChooseAccess'];
    needCompleteData = json['needCompleteData'];

    requiredAuthentication = json['requiredAuthentication'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['expiredAt'] = this.expiredAt;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['login'] = this.login;
    data['photo'] = this.photo;
    data['codeKey'] = this.codeKey;
    data['needChooseAccess'] = this.needChooseAccess;
    data['needCompleteData'] = this.needCompleteData;

    data['requiredAuthentication'] = this.requiredAuthentication;
    return data;
  }

  @override
  String toString() {
    return 'AccountResponseData(accessToken: $accessToken, expiredAt: $expiredAt, fullName: $fullName, email: $email, login: $login, photo: $photo, requiredAuthentication: $requiredAuthentication)';
  }
}
