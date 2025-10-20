import 'package:dnn_core/all_exports.dart';

class DnnResponse extends SqfLiteBase<DnnResponse> {
  int? id;
  String? rapidocTimeFinish;
  bool? rapidocWorkerEnable;
  String? efiAccountNumber;
  String? mpApplicationId;
  String? mpAcessToken;
  String? mpPublicKey;
  String? mpNotificationUrl;
  String? mpTestApplicationId;
  String? mpTestAcessToken;
  String? mpTestPublicKey;
  String? mpTestNotificationUrl;
  bool? mpProduction;
  bool? efiProduction;
  bool? isPlanLoadPartial;
  bool? modeStreaming;
  String? key;
  DateTime? updateAt;
  DnnResponse(
      {this.id,
      this.rapidocTimeFinish,
      this.rapidocWorkerEnable,
      this.efiAccountNumber,
      this.mpApplicationId,
      this.mpAcessToken,
      this.mpPublicKey,
      this.mpNotificationUrl,
      this.mpTestApplicationId,
      this.mpTestAcessToken,
      this.mpTestPublicKey,
      this.mpTestNotificationUrl,
      this.efiProduction,
      this.mpProduction,
      this.isPlanLoadPartial,
      this.modeStreaming,
      this.key,
      this.updateAt})
      : super(DatabaseModels.dnnResponse);

  DnnResponse.fromJson(Map<String, dynamic> json)
      : super(DatabaseModels.dnnResponse) {
    id = json['id'];
    rapidocTimeFinish = json['rapidocTimeFinish'];
    rapidocWorkerEnable = json['rapidocWorkerEnable'];
    efiAccountNumber = json['efiAccountNumber'];
    mpApplicationId = json['mpApplicationId'];
    mpAcessToken = json['mpAcessToken'];
    mpPublicKey = json['mpPublicKey'];
    mpNotificationUrl = json['mpNotificationUrl'];
    mpTestApplicationId = json['mpTestApplicationId'];
    mpTestAcessToken = json['mpTestAcessToken'];
    mpTestPublicKey = json['mpTestPublicKey'];
    mpTestNotificationUrl = json['mpTestNotificationUrl'];
    efiProduction = json['efiProduction'];
    mpProduction = json['mpProduction'];
    isPlanLoadPartial = json['isPlanLoadPartial'];
    modeStreaming = json['modeStreaming'];
    key = json['key'];
    updateAt =
        json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rapidocTimeFinish'] = this.rapidocTimeFinish;
    data['rapidocWorkerEnable'] = this.rapidocWorkerEnable;
    data['efiAccountNumber'] = this.efiAccountNumber;
    data['mpApplicationId'] = this.mpApplicationId;
    data['mpAcessToken'] = this.mpAcessToken;
    data['mpPublicKey'] = this.mpPublicKey;
    data['mpNotificationUrl'] = this.mpNotificationUrl;
    data['mpTestApplicationId'] = this.mpTestApplicationId;
    data['mpTestAcessToken'] = this.mpTestAcessToken;
    data['mpTestPublicKey'] = this.mpTestPublicKey;
    data['mpTestNotificationUrl'] = this.mpTestNotificationUrl;
    data['efiProduction'] = this.efiProduction;
    data['mpProduction'] = this.mpProduction;
    data['isPlanLoadPartial'] = this.isPlanLoadPartial;
    data['key'] = this.key;
    data['modeStreaming'] = this.modeStreaming;
    data['updateAt'] = this.updateAt?.toIso8601String();
    return data;
  }

  Future<DnnResponse?> getData() async {
    var list = await getAll<DnnResponse>(DnnResponse.fromJson);
    return list.isNotEmpty ? list.first : null;
  }
}
