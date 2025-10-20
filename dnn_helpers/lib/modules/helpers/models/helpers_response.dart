import 'package:dnn_core/all_exports.dart';

class HelperResponse extends SqfLiteBase<HelperResponse> {
  DateTime? updateAt;
  int? count;
  List<HelperModel>? helperModel;

  HelperResponse({this.updateAt, this.count, this.helperModel})
      : super(DatabaseModels.helperResponse);

  HelperResponse.fromJson(Map<String, dynamic> json)
      : super(DatabaseModels.helperResponse) {
    updateAt =
        json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null;
    count = json['count'];
    if (json['data'] != null) {
      helperModel = <HelperModel>[];
      json['data'].forEach((v) {
        helperModel!.add(HelperModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['updateAt'] = updateAt?.toIso8601String();
    data['count'] = count;
    if (helperModel != null) {
      data['data'] = helperModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Future<HelperResponse?> getData() async {
    var list = await getAll<HelperResponse>(HelperResponse.fromJson);
    return list.isNotEmpty ? list.first : null;
  }
}

class HelperModel {
  int? id;
  String? name;
  String? title;
  String? descriptions;
  String? icon;
  int? orders;
  String? tags;
  List<HelperModel>? childs;

  HelperModel(
      {this.id,
      this.name,
      this.title,
      this.descriptions,
      this.icon,
      this.orders,
      this.tags,
      this.childs});

  HelperModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    descriptions = json['descriptions'];
    icon = json['icon'];
    orders = json['orders'];
    tags = json['tags'];
    if (json['childs'] != null) {
      childs = <HelperModel>[];
      json['childs'].forEach((v) {
        childs!.add(HelperModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['title'] = title;
    data['descriptions'] = descriptions;
    data['icon'] = icon;
    data['orders'] = orders;
    data['tags'] = tags;
    if (childs != null) {
      data['childs'] = childs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
