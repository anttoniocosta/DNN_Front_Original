import 'package:dnn_core/models/payment/payment_response_model.dart';

class ScheduleSuccessResponseModel {
  bool? paymentConfirmed;
  bool? paymentAwaiting;
  bool? needWait;
  String? scheduleConsultationId;
  String? paymentId;
  String? screeningId;
  String? scheduleServicesId;
  bool? hasScreening;
  bool? openRapidoc;
  String? rapidocUrl;
  PaymentPixModel? pix;
  String? pdf;
  String? barcode;

  ScheduleSuccessResponseModel({
    this.paymentConfirmed,
    this.paymentAwaiting,
    this.needWait,
    this.scheduleConsultationId,
    this.paymentId,
    this.screeningId,
    this.pix,
    this.pdf,
    this.barcode,
  });

  ScheduleSuccessResponseModel.fromJson(Map<String, dynamic> json) {
    paymentConfirmed = json['paymentConfirmed'];
    paymentAwaiting = json['paymentAwaiting'];
    needWait = json['needWait'];
    scheduleConsultationId = json['scheduleConsultationId'];
    paymentId = json['paymentId'];
    screeningId = json['screeningId'];
    scheduleServicesId = json['scheduleServicesId'];
    hasScreening = json['hasScreening'];
    openRapidoc = json['openRapidoc'];
    rapidocUrl = json['rapidocUrl'];
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
    data['scheduleConsultationId'] = this.scheduleConsultationId;
    data['paymentId'] = this.paymentId;
    data['screeningId'] = this.screeningId;
    data['rapidocUrl'] = this.rapidocUrl;
    data['openRapidoc'] = this.openRapidoc;
    data['hasScreening'] = this.hasScreening;
    data['scheduleServicesId'] = this.scheduleServicesId;
    if (this.pix != null) {
      data['pix'] = this.pix!.toJson();
    }
    data['pdf'] = this.pdf;
    data['barcode'] = this.barcode;
    return data;
  }
}
