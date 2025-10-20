import 'package:dnn_core/all_exports.dart';

class PaymentResponseModel {
  bool? paymentConfirmed;
  bool? paymentAwaiting;
  bool? needWait;
  String? orderId;
  String? paymentId;
  PaymentPixModel? pix;
  String? pdf;
  String? barcode;

  PaymentResponseModel({
    this.paymentConfirmed,
    this.paymentAwaiting,
    this.needWait,
    this.orderId,
    this.paymentId,
    this.pix,
    this.pdf,
    this.barcode,
  });

  PaymentResponseModel.fromScheduleModel(ScheduleSuccessResponseModel model)
      : this(
          paymentConfirmed: model.paymentConfirmed,
          paymentAwaiting: model.paymentAwaiting,
          needWait: model.needWait,
          orderId: model.scheduleConsultationId,
          paymentId: model.paymentId,
          pix: model.pix,
          pdf: model.pdf,
          barcode: model.barcode,
        );

  PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    paymentConfirmed = json['paymentConfirmed'];
    paymentAwaiting = json['paymentAwaiting'];
    needWait = json['needWait'];
    orderId = json['orderId'];
    paymentId = json['paymentId'];
    pix =
        json['pix'] != null ? new PaymentPixModel.fromJson(json['pix']) : null;
    pdf = json['pdf'];
    barcode = json['barcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentConfirmed'] = this.paymentConfirmed;
    data['paymentAwaiting'] = this.paymentAwaiting;
    data['needWait'] = this.needWait;
    data['orderId'] = this.orderId;
    data['paymentId'] = this.paymentId;
    if (this.pix != null) {
      data['pix'] = this.pix!.toJson();
    }
    data['pdf'] = this.pdf;
    data['barcode'] = this.barcode;
    return data;
  }
}

class PaymentPixModel {
  int? locId;
  String? qrcode;

  PaymentPixModel({this.locId, this.qrcode});

  PaymentPixModel.fromJson(Map<String, dynamic> json) {
    locId = json['locId'];
    qrcode = json['qrcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locId'] = this.locId;
    data['qrcode'] = this.qrcode;
    return data;
  }
}
