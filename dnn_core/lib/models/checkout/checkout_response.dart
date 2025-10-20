class PaymentResponse {
  String? message;
  CheckoutDataModel? data;

  PaymentResponse({this.message, this.data});

  PaymentResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? new CheckoutDataModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CheckoutDataModel {
  String? contractId;
  String? paymentId;
  PixModel? pix;
  bool? paymentConfirmed;
  bool? paymentAwaiting;
  String? barcode;
  String? pdf;

  CheckoutDataModel(
      {this.contractId,
      this.paymentId,
      this.pix,
      this.paymentConfirmed,
      this.paymentAwaiting,
      this.barcode,
      this.pdf});

  CheckoutDataModel.fromJson(Map<String, dynamic> json) {
    contractId = json['contractId'];
    paymentId = json['paymentId'];
    paymentConfirmed = json['paymentConfirmed'];
    paymentAwaiting = json['paymentAwaiting'];
    barcode = json['barcode'];
    pdf = json['pdf'];
    pix = json['pix'] != null ? new PixModel.fromJson(json['pix']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contractId'] = this.contractId;
    data['paymentId'] = this.paymentId;
    data['paymentAwaiting'] = this.paymentAwaiting;
    data['paymentConfirmed'] = this.paymentConfirmed;
    data['barcode'] = this.barcode;
    data['pdf'] = this.pdf;
    if (this.pix != null) {
      data['pix'] = this.pix!.toJson();
    }
    return data;
  }
}

class PixModel {
  int? locId;
  String? qrcode;

  PixModel({this.locId, this.qrcode});

  PixModel.fromJson(Map<String, dynamic> json) {
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
