import 'package:dnn_core/core/export.dart';

class PagesResponse extends SqfLiteBase<PagesResponse> {
  DateTime? updateAt;
  int? count;
  List<PagesModel>? data;

  PagesResponse({this.updateAt, this.count, this.data})
      : super(DatabaseModels.pagesResponse);

  PagesResponse.fromJson(Map<String, dynamic> json)
      : super(DatabaseModels.pagesResponse) {
    updateAt =
        json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null;
    count = json['count'];
    if (json['data'] != null) {
      data = <PagesModel>[];
      json['data'].forEach((v) {
        data!.add(PagesModel.fromJson(v));
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

  Future<PagesResponse?> getData() async {
    var list = await getAll<PagesResponse>(PagesResponse.fromJson);
    return list.isNotEmpty ? list.first : null;
  }
}

class PagesModel {
  int? id;
  String? name;
  String? tag;
  String? content;

  PagesModel({this.id, this.name, this.tag, this.content});

  PagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tag = json['tag'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['tag'] = tag;
    data['content'] = content;
    return data;
  }
}
