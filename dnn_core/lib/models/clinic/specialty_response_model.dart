class SpecialtyResponseModel {
  final int? id;
  final String? name;

  SpecialtyResponseModel({this.id, this.name});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory SpecialtyResponseModel.fromJson(Map<String, dynamic> map) {
    return SpecialtyResponseModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }
}
