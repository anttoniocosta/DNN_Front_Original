import '../../all_exports.dart';

class PaymentResquestModel {
  String? cartId;
  String? orderId;
  int? useTermsId;
  int? typePaymentId;
  int? mercadoPagoId;
  PaymentCardModel? card;
  List<String>? paymentIds;
  MercadoPagoRequest? mercadoPago;

  PaymentResquestModel(
      {this.cartId,
      this.orderId,
      this.useTermsId,
      this.typePaymentId,
      this.mercadoPagoId,
      this.paymentIds,
      this.card,
      this.mercadoPago});

  PaymentResquestModel.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    orderId = json['orderId'];
    useTermsId = json['useTermsId'];
    typePaymentId = json['typePaymentId'];
    mercadoPagoId = json['mercadoPagoId'];
    paymentIds = json['paymentIds'];
    card = json['card'] != null
        ? new PaymentCardModel.fromJson(json['card'])
        : null;
    mercadoPago = json['mercadoPago'] != null
        ? new MercadoPagoRequest.fromJson(json['mercadoPago'])
        : null;
  }

  Map<String, dynamic> toJsonPay() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartId'] = this.cartId;
    data['orderId'] = this.orderId;
    data['useTermsId'] = this.useTermsId;
    data['typePaymentId'] = this.typePaymentId;
    data['mercadoPagoId'] = this.mercadoPagoId;
    data['paymentIds'] = this.paymentIds;
    if (this.card != null) {
      data['card'] = this.card!.toJson();
    }
    if (this.mercadoPago != null) {
      data['mercadoPago'] = this.mercadoPago!.toJson();
    }
    return data;
  }

  Map<String, dynamic> toJsonRenewal() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (data['cartId'] != null) data['cartId'] = this.cartId;
    data['orderId'] = this.orderId;
    if (data['useTermsId'] != null) data['useTermsId'] = this.useTermsId;
    data['typePaymentId'] = this.typePaymentId;
    data['mercadoPagoId'] = this.mercadoPagoId;
    data['paymentIds'] = this.paymentIds;
    if (this.card != null) {
      data['card'] = this.card!.toJson();
    }
    if (this.mercadoPago != null) {
      data['mercadoPago'] = this.mercadoPago!.toJson();
    }
    return data;
  }
}

class PaymentCardModel {
  String? document;
  String? birth;
  String? holderName;
  String? cardMask;
  String? paymentToken;
  int? installments;
  String? ipAddress;
  String? brand;
  bool? recurringPayment;
  String? zipcode;
  String? street;
  String? number;
  String? complement;
  String? neighborhood;
  String? city;
  String? state;

  PaymentCardModel(
      {this.document,
      this.birth,
      this.holderName,
      this.cardMask,
      this.paymentToken,
      this.installments,
      this.ipAddress,
      this.brand,
      this.recurringPayment,
      this.zipcode,
      this.street,
      this.number,
      this.complement,
      this.neighborhood,
      this.city,
      this.state});

  PaymentCardModel.fromJson(Map<String, dynamic> json) {
    document = json['document'];
    birth = json['birth'];
    holderName = json['holderName'];
    cardMask = json['cardMask'];
    paymentToken = json['paymentToken'];
    installments = json['installments'];
    ipAddress = json['ip_address'];
    brand = json['brand'];
    recurringPayment = json['recurringPayment'];
    zipcode = json['zipcode'];
    street = json['street'];
    number = json['number'];
    complement = json['complement'];
    neighborhood = json['neighborhood'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document'] = this.document;
    data['birth'] = this.birth;
    data['holderName'] = this.holderName;
    data['cardMask'] = this.cardMask;
    data['paymentToken'] = this.paymentToken;
    data['installments'] = this.installments;
    data['ip_address'] = this.ipAddress;
    data['brand'] = this.brand;
    data['recurringPayment'] = this.recurringPayment;
    data['zipcode'] = this.zipcode;
    data['street'] = this.street;
    data['number'] = this.number;
    data['complement'] = this.complement;
    data['neighborhood'] = this.neighborhood;
    data['city'] = this.city;
    data['state'] = this.state;
    return data;
  }
}
