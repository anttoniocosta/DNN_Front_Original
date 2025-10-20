class GatewayResponse {
  String? updateAt;
  int? count;
  List<GatewayDataModel>? data;

  GatewayResponse({this.updateAt, this.count, this.data});

  GatewayResponse.fromJson(Map<String, dynamic> json) {
    updateAt = json['updateAt'];
    count = json['count'];
    if (json['data'] != null) {
      data = <GatewayDataModel>[];
      json['data'].forEach((v) {
        data!.add(new GatewayDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updateAt'] = this.updateAt;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GatewayDataModel {
  int? id;
  String? name;
  int? orders;
  GatewayModel? gateway;

  GatewayDataModel({this.id, this.name, this.orders, this.gateway});

  GatewayDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    orders = json['orders'] ?? 1;
    gateway = json['gateway'] != null
        ? new GatewayModel.fromJson(json['gateway'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['orders'] = this.orders;
    if (this.gateway != null) {
      data['gateway'] = this.gateway!.toJson();
    }
    return data;
  }
}

class GatewayModel {
  int? id;
  String? name;

  GatewayModel({this.id, this.name});

  GatewayModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
