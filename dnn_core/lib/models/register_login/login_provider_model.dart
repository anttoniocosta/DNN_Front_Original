class LoginProviderModel {
  String? email;
  String? providerId;
  String? name;
  String? providerName;
  String? firebaseToken;
  String? photo;

  LoginProviderModel({
    this.email,
    this.providerId,
    this.name,
    this.providerName,
    this.firebaseToken,
    this.photo,
  });

  LoginProviderModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    providerId = json['providerId'];
    name = json['name'];
    providerName = json['providerName'];
    firebaseToken = json['firebaseToken'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['providerId'] = this.providerId;
    data['name'] = this.name;
    data['providerName'] = this.providerName;
    data['firebaseToken'] = this.firebaseToken;
    data['photo'] = this.photo;

    return data;
  }
}
