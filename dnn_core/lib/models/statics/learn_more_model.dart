import 'package:dnn_core/all_exports.dart';

class LearnMoreResponse extends SqfLiteBase<LearnMoreResponse> {
  DateTime? updateAt;
  int? count;
  List<LearMoreModel>? learMoreModel;

  LearnMoreResponse({this.updateAt, this.count, this.learMoreModel})
      : super(DatabaseModels.learnMoreResponse);

  LearnMoreResponse.fromJson(Map<String, dynamic> json)
      : super(DatabaseModels.learnMoreResponse) {
    updateAt =
        json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null;
    count = json['count'];
    if (json['data'] != null) {
      learMoreModel = <LearMoreModel>[];
      json['data'].forEach((v) {
        learMoreModel!.add(new LearMoreModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updateAt'] = this.updateAt?.toIso8601String();
    data['count'] = this.count;
    if (this.learMoreModel != null) {
      data['data'] = this.learMoreModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Future<LearnMoreResponse?> getData() async {
    var list = await getAll<LearnMoreResponse>(LearnMoreResponse.fromJson);
    return list.isNotEmpty ? list.first : null;
  }
}

class LearMoreModel {
  int? id;
  String? name;
  String? tag;
  String? content;

  LearMoreModel({this.id, this.name, this.tag, this.content});

  LearMoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tag = json['tag'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tag'] = this.tag;
    data['content'] = this.content;
    return data;
  }
}
