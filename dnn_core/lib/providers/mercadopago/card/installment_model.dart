class InstallmentModel {
  String? paymentMethodId;
  String? paymentTypeId;
  Issuer? issuer;
  String? processingMode;
  List<PayerCosts>? payerCosts;

  InstallmentModel({
    this.paymentMethodId,
    this.paymentTypeId,
    this.issuer,
    this.processingMode,
    this.payerCosts,
  });

  InstallmentModel.fromJson(Map<String, dynamic> json) {
    paymentMethodId = json['payment_method_id'];
    paymentTypeId = json['payment_type_id'];
    issuer =
        json['issuer'] != null ? new Issuer.fromJson(json['issuer']) : null;
    processingMode = json['processing_mode'];
    if (json['payer_costs'] != null) {
      payerCosts = <PayerCosts>[];
      json['payer_costs'].forEach((v) {
        payerCosts!.add(new PayerCosts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method_id'] = this.paymentMethodId;
    data['payment_type_id'] = this.paymentTypeId;
    if (this.issuer != null) {
      data['issuer'] = this.issuer!.toJson();
    }
    data['processing_mode'] = this.processingMode;
    if (this.payerCosts != null) {
      data['payer_costs'] = this.payerCosts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Issuer {
  String? id;
  String? name;
  String? secureThumbnail;
  String? thumbnail;

  Issuer({this.id, this.name, this.secureThumbnail, this.thumbnail});

  Issuer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    secureThumbnail = json['secure_thumbnail'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['secure_thumbnail'] = this.secureThumbnail;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}

class PayerCosts {
  int? installments;
  int? discountRate;
  List<String>? installmentRateCollector;
  int? minAllowedAmount;
  int? maxAllowedAmount;
  String? recommendedMessage;
  double? installmentAmount;
  double? totalAmount;
  String? paymentMethodOptionId;

  PayerCosts(
      {this.installments,
      this.discountRate,
      this.installmentRateCollector,
      this.minAllowedAmount,
      this.maxAllowedAmount,
      this.recommendedMessage,
      this.installmentAmount,
      this.totalAmount,
      this.paymentMethodOptionId});

  PayerCosts.fromJson(Map<String, dynamic> json) {
    installments = json['installments'];
    discountRate = json['discount_rate'];

    installmentRateCollector =
        json['installment_rate_collector'].cast<String>();
    minAllowedAmount = json['min_allowed_amount'];
    maxAllowedAmount = json['max_allowed_amount'];
    recommendedMessage = json['recommended_message'];
    installmentAmount = (json['installment_amount'] is int)
        ? (json['installment_amount'] as int).toDouble()
        : json['installment_amount'];
    totalAmount = (json['totalAmount'] is int)
        ? (json['totalAmount'] as int).toDouble()
        : json['totalAmount'];

    paymentMethodOptionId = json['payment_method_option_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['installments'] = this.installments;
    data['discount_rate'] = this.discountRate;

    data['installment_rate_collector'] = this.installmentRateCollector;
    data['min_allowed_amount'] = this.minAllowedAmount;
    data['max_allowed_amount'] = this.maxAllowedAmount;
    data['recommended_message'] = this.recommendedMessage;
    data['installment_amount'] = this.installmentAmount;
    data['total_amount'] = this.totalAmount;
    data['payment_method_option_id'] = this.paymentMethodOptionId;
    return data;
  }
}
