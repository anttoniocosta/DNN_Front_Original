class RapidocResponse {
  String? message;
  int? count;
  RapidocModel? data;

  RapidocResponse({this.message, this.count, this.data});

  RapidocResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    count = json['count'];
    data =
        json['data'] != null ? new RapidocModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class RapidocModel {
  String? message;
  bool? success;
  String? url;
  String? serviceId;
  int? historyId;

  RapidocModel({this.message, this.success, this.url, this.historyId});

  RapidocModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    url = json['url'];
    serviceId = json['serviceId'];
    historyId = json['historyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    data['url'] = this.url;
    data['serviceId'] = this.serviceId;
    data['historyId'] = this.historyId;
    return data;
  }
}
