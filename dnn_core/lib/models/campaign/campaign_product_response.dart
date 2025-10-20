import 'package:dnn_core/all_exports.dart';

class CampaignProductModel {
  String? id;
  String? title;
  String? descriptions;
  String? benefits;
  List<String>? benefitsList;
  int? orders;
  bool? enabled;
  bool? flgHighlight;
  String? highlightText;
  String? urlWebView;
  bool? isSubscription;
  int? recurrenceId;
  String? recurrenceName;
  String? useTermsCustom;
  double? price;
  int? level;
  List<Prices>? prices;
  List<Claims>? claims;

  String? campaignProductsPrincipalId;
  bool? hasFidelity;
  int? fidelityMonth;
  bool? hasComplements;
  List<GatewayDataModel>? gateways;

  CampaignProductModel({
    this.id,
    this.title,
    this.descriptions,
    this.benefits,
    this.benefitsList,
    this.orders,
    this.enabled,
    this.flgHighlight,
    this.highlightText,
    this.urlWebView,
    this.isSubscription,
    this.recurrenceId,
    this.recurrenceName,
    this.price,
    this.level,
    this.prices,
    this.claims,
    this.campaignProductsPrincipalId,
    this.hasFidelity,
    this.fidelityMonth,
    this.gateways,
    this.hasComplements,
    this.useTermsCustom,
  });

  CampaignProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    descriptions = json['descriptions'];
    benefits = json['benefits'];
    benefitsList = json['benefitsList'].cast<String>();
    orders = json['orders'];
    enabled = json['enabled'];
    flgHighlight = json['flgHighlight'];
    highlightText = json['highlightText'];
    urlWebView = json['urlWebView'];
    isSubscription = json['isSubscription'];
    recurrenceId = json['recurrenceId'];
    recurrenceName = json['recurrenceName'];
    price = json['price'];
    level = json['level'];
    hasFidelity = json['hasFidelity'];
    campaignProductsPrincipalId = json['campaignProductsPrincipalId'];
    fidelityMonth = json['fidelityMonth'];
    hasComplements = json['hasComplements'];
    useTermsCustom = json['useTermsCustom'];
    if (json['prices'] != null) {
      prices = <Prices>[];
      json['prices'].forEach((v) {
        prices!.add(new Prices.fromJson(v));
      });
    }
    if (json['claims'] != null) {
      claims = <Claims>[];
      json['claims'].forEach((v) {
        claims!.add(new Claims.fromJson(v));
      });
    }
    if (json['gateways'] != null) {
      gateways = <GatewayDataModel>[];
      json['gateways'].forEach((v) {
        gateways!.add(new GatewayDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['descriptions'] = this.descriptions;
    data['benefits'] = this.benefits;
    data['benefitsList'] = this.benefitsList;
    data['orders'] = this.orders;
    data['enabled'] = this.enabled;
    data['flgHighlight'] = this.flgHighlight;
    data['highlightText'] = this.highlightText;
    data['urlWebView'] = this.urlWebView;
    data['isSubscription'] = this.isSubscription;
    data['recurrenceId'] = this.recurrenceId;
    data['recurrenceName'] = this.recurrenceName;
    data['price'] = this.price;
    data['level'] = this.level;
    data['hasComplements'] = this.hasComplements;
    data['fidelityMonth'] = this.fidelityMonth;
    data['hasFidelity'] = this.hasFidelity;
    data['campaignProductsPrincipalId'] = this.campaignProductsPrincipalId;
    data['useTermsCustom'] = this.useTermsCustom;
    if (this.prices != null) {
      data['prices'] = this.prices!.map((v) => v.toJson()).toList();
    }
    if (this.claims != null) {
      data['claims'] = this.claims!.map((v) => v.toJson()).toList();
    }
    if (this.gateways != null) {
      data['gateways'] = this.gateways!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prices {
  int? id;
  int? number;
  String? title;
  double? price;

  Prices({this.id, this.number, this.title, this.price});

  Prices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    title = json['title'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['title'] = this.title;
    data['price'] = this.price;
    return data;
  }
}

class Claims {
  String? id;
  String? name;
  int? qtdy;
  bool? flgSystem;

  Claims({this.id, this.name, this.qtdy, this.flgSystem});

  Claims.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    qtdy = json['qtdy'];
    flgSystem = json['flgSystem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['qtdy'] = this.qtdy;
    data['flgSystem'] = this.flgSystem;
    return data;
  }
}
