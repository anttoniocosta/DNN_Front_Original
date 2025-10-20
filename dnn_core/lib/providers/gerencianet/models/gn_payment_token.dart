class GNPaymentToken {
  String? code;
  String? error;
  String? errorDescription;
  GNSucessToken? data;

  GNPaymentToken({this.code, this.error, this.errorDescription, this.data});

  GNPaymentToken.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();

    error = json['error'];
    errorDescription = json['error_description'];
    data =
        json['data'] != null ? new GNSucessToken.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['error'] = this.error;
    data['error_description'] = this.errorDescription;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ErrorDescription {
  String? property;
  String? message;

  ErrorDescription({this.property, this.message});

  ErrorDescription.fromJson(Map<String, dynamic> json) {
    property = json['property'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['property'] = this.property;
    data['message'] = this.message;
    return data;
  }
}

class GNSucessToken {
  String? paymentToken;
  String? cardMask;

  GNSucessToken({this.paymentToken, this.cardMask});

  GNSucessToken.fromJson(Map<String, dynamic> json) {
    paymentToken = json['payment_token'];
    cardMask = json['card_mask'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_token'] = this.paymentToken;
    data['card_mask'] = this.cardMask;
    return data;
  }
}
