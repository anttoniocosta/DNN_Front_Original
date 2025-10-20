import 'package:dnn_core/all_exports.dart';

class SpecialtyResponse extends SqfLiteBase<SpecialtyResponse> {
  DateTime? updateAt;
  int? count;
  List<SpecialtyModel>? data;

  SpecialtyResponse({this.updateAt, this.count, this.data})
      : super(DatabaseModels.specialtyResponse);

  SpecialtyResponse.fromJson(Map<String, dynamic> json)
      : super(DatabaseModels.specialtyResponse) {
    updateAt =
        json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null;
    count = json['count'];
    if (json['data'] != null) {
      data = <SpecialtyModel>[];
      json['data'].forEach((v) {
        data!.add(new SpecialtyModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updateAt'] = this.updateAt?.toIso8601String();
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Future<SpecialtyResponse?> getData() async {
    var list = await getAll<SpecialtyResponse>(SpecialtyResponse.fromJson);
    return list.isNotEmpty ? list.first : null;
  }

  @override
  String toString() =>
      'SpecialtyResponse(updateAt: $updateAt, count: $count, data: $data)';
}

class SpecialtyModel {
  int? id;
  String? name;
  int? order;
  String? contractId;

  SpecialtyModel({this.id, this.name, this.order});

  SpecialtyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    order = json['order'];
    contractId = json['contractId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['order'] = this.order;
    data['contractId'] = this.contractId;
    return data;
  }
}
