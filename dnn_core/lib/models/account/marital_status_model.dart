import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/get_export.dart';

class MaritalStatusModel extends SqfLiteBase<MaritalStatusModel> {
  final int? id;
  final String? text;

  MaritalStatusModel({this.id, this.text})
      : super(DatabaseModels.maritalStatusModel);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'text': text,
    };
  }

  factory MaritalStatusModel.fromJson(Map<String, dynamic> map) {
    return MaritalStatusModel(
      id: map['id'] != null ? map['id'] as int : null,
      text: map['text'] != null ? map['text'] as String : null,
    );
  }

  static int getMaritalId(String text) {
    if (text.isNotEmpty) {
      return accountController.maritalStatusList
          .firstWhere((e) => e.text == text.toUpperCase())
          .id!;
    } else {
      return 0;
    }
  }

  static String getMaritalText(int id) {
    return accountController.maritalStatusList
        .firstWhere((e) => e.id == id)
        .text!
        .capitalizeFirst!;
  }

  Future<List<MaritalStatusModel>?> getData() async {
    var list = await getAll<MaritalStatusModel>(MaritalStatusModel.fromJson);
    return list;
  }
}
