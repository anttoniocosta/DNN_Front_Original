// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginModel {
  String? login;
  String? password;
  String? firebaseToken;

  LoginModel({this.login, this.password, this.firebaseToken});

  LoginModel.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    password = json['password'];
    firebaseToken = json['firebaseToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['password'] = this.password;
    data['firebaseToken'] = this.firebaseToken;
    return data;
  }

  @override
  String toString() =>
      'LoginModel(login: $login, password: $password, firebaseToken: $firebaseToken)';
}
