import '../all_exports.dart';

class SegmentsResponse extends SqfLiteBase<SegmentsResponse> {
  DateTime? updateAt;
  int? count;
  List<SegmentsData>? data;

  SegmentsResponse({this.updateAt, this.count, this.data})
      : super(DatabaseModels.segmentsResponse);

  SegmentsResponse.fromJson(Map<String, dynamic> json)
      : super(DatabaseModels.segmentsResponse) {
    updateAt =
        json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null;
    count = json['count'];
    if (json['data'] != null) {
      data = <SegmentsData>[];
      json['data'].forEach((v) {
        data!.add(new SegmentsData.fromJson(v));
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

  Future<SegmentsResponse?> getData() async {
    var list = await getAll<SegmentsResponse>(SegmentsResponse.fromJson);
    return list.isNotEmpty ? list.first : null;
  }
}

class SegmentsData {
  String? name;
  String? description;
  String? title;
  String? iconType;
  String? iconName;
  int? order;
  List<SpecialtyModel>? specialtys;
  List<AppsModel>? apps;
  List<String>? plansId;
  SegmentsData(
      {this.name,
      this.description,
      this.iconType,
      this.title,
      this.iconName,
      this.order,
      this.apps,
      this.specialtys,
      this.plansId});

  SegmentsData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    iconType = json['iconType'];
    iconName = json['iconName'];
    title = json['title'];
    order = json['order'];
    if (json['specialtys'] != null) {
      specialtys = <SpecialtyModel>[];
      json['specialtys'].forEach((v) {
        specialtys!.add(new SpecialtyModel.fromJson(v));
      });
    }
    if (json['apps'] != null) {
      apps = <AppsModel>[];
      json['apps'].forEach((v) {
        apps!.add(new AppsModel.fromJson(v));
      });
    }

    plansId = json['plansId'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['iconType'] = this.iconType;
    data['iconName'] = this.iconName;
    data['title'] = this.title;
    data['order'] = this.order;
    if (this.specialtys != null) {
      data['specialtys'] = this.specialtys!.map((v) => v.toJson()).toList();
    }
    if (this.apps != null) {
      data['apps'] = this.apps!.map((v) => v.toJson()).toList();
    }

    data['plansId'] = this.plansId;
    return data;
  }
}

class AppsModel {
  int? id;
  String? name;
  String? tag;

  AppsModel({this.id, this.name, this.tag});

  AppsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tag'] = this.tag;
    return data;
  }
}
