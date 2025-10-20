class AppVersionModel {
  String? packageId;
  String? android;
  String? ios;
  String? urlApple;
  String? urlGoogle;

  AppVersionModel({this.packageId, this.android, this.ios});

  AppVersionModel.fromJson(Map<String, dynamic> json) {
    packageId = json['packageId'];
    android = json['android'];
    ios = json['ios'];
    urlApple = json['urlApple'];
    urlGoogle = json['urlGoogle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['packageId'] = packageId;
    data['android'] = android;
    data['ios'] = ios;
    data['urlApple'] = urlApple;
    data['urlGoogle'] = urlGoogle;
    return data;
  }
}
