import 'package:dnn_core/all_exports.dart';

class UseTermsResponse extends SqfLiteBase<PlanResponse> {
  String? guidId;
  DateTime? updateAt;
  int? count;
  List<UseTermsModel>? data;

  UseTermsResponse({this.guidId, this.updateAt, this.count, this.data})
      : super(DatabaseModels.useTermsResponse);

  UseTermsResponse.fromJson(Map<String, dynamic> json)
      : super(DatabaseModels.useTermsResponse) {
    guidId = json['guidId'];
    updateAt =
        json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null;
    count = json['count'];
    if (json['data'] != null) {
      data = <UseTermsModel>[];
      json['data'].forEach((v) {
        data!.add(UseTermsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['updateAt'] = updateAt?.toIso8601String();
    data['count'] = count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Future<UseTermsResponse?> getData() async {
    var list = await getAll<UseTermsResponse>(UseTermsResponse.fromJson);
    return list.isNotEmpty ? list.first : null;
  }
}

class UseTermsModel {
  int? id;
  String? version;
  String? content;
  String? publishDate;
  Type? type;

  UseTermsModel(
      {this.id, this.version, this.content, this.publishDate, this.type});

  UseTermsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    version = json['version'];
    content = json['content'];
    publishDate = json['publishDate'];
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['version'] = version;
    data['content'] = content;
    data['publishDate'] = publishDate;
    if (type != null) {
      data['type'] = type!.toJson();
    }
    return data;
  }

  static void saveUseTerms(int id) {
    storage.saveLocalData(key: StorageKeys.USE_TERMS_ID, data: id.toString());
  }

  static Future<int?> getUseTerms(int id) async {
    final id = await storage.getLocalData(key: StorageKeys.USE_TERMS_ID);
    if (id != null) return int.parse(id);
    return null;
  }
}

class Type {
  int? id;
  String? name;
  String? tag;

  Type({this.id, this.name, this.tag});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['tag'] = tag;
    return data;
  }
}
