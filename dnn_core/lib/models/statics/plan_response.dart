// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dnn_core/all_exports.dart';

class PlanResponse extends SqfLiteBase<PlanResponse> {
  DateTime? updateAt;
  int? count;
  PlansData? data;

  PlanResponse({this.updateAt, this.count, this.data})
      : super(DatabaseModels.planResponse);

  PlanResponse.fromJson(Map<String, dynamic> json)
      : super(DatabaseModels.planResponse) {
    updateAt =
        json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null;
    count = json['count'];
    data = json['data'] != null ? new PlansData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updateAt'] = this.updateAt?.toIso8601String();
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  Future<PlanResponse?> getData() async {
    var list = await getAll<PlanResponse>(PlanResponse.fromJson);
    return list.isNotEmpty ? list.first : null;
  }
}

class PlansData {
  PlansModel? single;
  List<PlansModel>? plans;

  PlansData({this.single, this.plans});

  PlansData.fromJson(Map<String, dynamic> json) {
    single =
        json['single'] != null ? new PlansModel.fromJson(json['single']) : null;
    if (json['plans'] != null) {
      plans = <PlansModel>[];
      json['plans'].forEach((v) {
        plans!.add(new PlansModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.single != null) {
      data['single'] = this.single!.toJson();
    }
    if (this.plans != null) {
      data['plans'] = this.plans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlansModel {
  String? id;
  String? name;
  String? mainPlanName;
  String? title;
  String? startTime;
  String? endTime;
  String? blockedDate;
  double? price;
  int? numberDependents;
  double? discount;
  List<String>? descriptions;
  bool? isSingle;
  bool? canRemoveDependents;
  int? numberAppointments;
  int? orders;
  bool? isSubscription;
  bool? flgHighlight;
  int? months;
  double? fine;
  int? delayDays;
  String? urlWebView;
  List<SpecialtyModel>? specialtys;
  List<PlansModel>? child;
  List<GatewayDataModel>? gateways;
  double? total;
  double? totalMonthly;
  bool? isWebView;
  bool? isDental;
  bool? isTelemedicine;
  bool? hasVariation;
  PlanType? planType;
  int? recurrence;
  int? fidelity;
  bool? showLoyaltyText;
  String? details;
  String? highlightText;
  bool? flgValueByMonth;
  bool? flgCompromise;
  String? compromiseText;
  PlansModel(
      {this.id,
      this.name,
      this.title,
      this.startTime,
      this.endTime,
      this.price,
      this.numberDependents,
      this.discount,
      this.descriptions,
      this.isSingle,
      this.canRemoveDependents,
      this.numberAppointments,
      this.orders,
      this.isSubscription,
      this.flgHighlight,
      this.months,
      this.fine,
      this.delayDays,
      this.urlWebView,
      this.specialtys,
      this.child,
      this.isWebView,
      this.total,
      this.totalMonthly,
      this.planType,
      this.recurrence,
      this.fidelity,
      this.isDental,
      this.isTelemedicine,
      this.hasVariation,
      this.highlightText,
      this.details,
      this.showLoyaltyText,
      this.flgValueByMonth,
      this.flgCompromise,
      this.compromiseText});

  PlansModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    mainPlanName = json['mainPlanName'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    price = json['price'];
    numberDependents = json['numberDependents'];
    discount = json['discount'];
    descriptions = json['descriptions'].cast<String>();
    isSingle = json['isSingle'];
    canRemoveDependents = json['canRemoveDependents'];
    numberAppointments = json['numberAppointments'];
    orders = json['orders'];
    isSubscription = json['isSubscription'];
    flgHighlight = json['flgHighlight'];
    months = json['months'];
    fine = json['fine'];
    isWebView = json['isWebView'];
    delayDays = json['delayDays'];
    recurrence = json['recurrence'];
    fidelity = json['fidelity'];
    hasVariation = json['hasVariation'];
    urlWebView = json['urlWebView'];
    isDental = json['isDental'];
    highlightText = json['highlightText'];
    details = json['details'];
    showLoyaltyText = json['showLoyaltyText'];
    isTelemedicine = json['isTelemedicine'];
    if (json['specialtys'] != null) {
      specialtys = <SpecialtyModel>[];
      json['specialtys'].forEach((v) {
        specialtys!.add(new SpecialtyModel.fromJson(v));
      });
    }
    if (json['child'] != null) {
      child = <PlansModel>[];
      json['child'].forEach((v) {
        child!.add(new PlansModel.fromJson(v));
      });
    }
    if (json['gateways'] != null) {
      gateways = <GatewayDataModel>[];
      json['gateways'].forEach((v) {
        gateways!.add(new GatewayDataModel.fromJson(v));
      });
    }
    planType = json['planType'] != null
        ? new PlanType.fromJson(json['planType'])
        : null;
    total = json['total'];
    totalMonthly = json['totalMonthly'];
    flgValueByMonth = json['flgValueByMonth'];
    flgCompromise = json['flgCompromise'];
    compromiseText = json['compromiseText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mainPlanName'] = this.mainPlanName;
    data['title'] = this.title;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['price'] = this.price;
    data['numberDependents'] = this.numberDependents;
    data['discount'] = this.discount;
    data['descriptions'] = this.descriptions;
    data['isSingle'] = this.isSingle;
    data['canRemoveDependents'] = this.canRemoveDependents;
    data['numberAppointments'] = this.numberAppointments;
    data['orders'] = this.orders;
    data['isSubscription'] = this.isSubscription;
    data['flgHighlight'] = this.flgHighlight;
    data['months'] = this.months;
    data['fine'] = this.fine;
    data['isWebView'] = this.isWebView;
    data['delayDays'] = this.delayDays;
    data['hasVariation'] = this.hasVariation;
    data['recurrence'] = this.recurrence;
    data['fidelity'] = this.fidelity;
    data['urlWebView'] = this.urlWebView;
    data['isDental'] = this.isDental;
    data['isTelemedicine'] = this.isTelemedicine;
    data['highlightText'] = this.highlightText;
    data['details'] = this.details;
    data['showLoyaltyText'] = this.showLoyaltyText;
    if (this.specialtys != null) {
      data['specialtys'] = this.specialtys!.map((v) => v.toJson()).toList();
    }
    if (this.child != null) {
      data['child'] = this.child!.map((v) => v.toJson()).toList();
    }
    if (this.gateways != null) {
      data['gateways'] = this.gateways!.map((v) => v.toJson()).toList();
    }
    if (this.planType != null) {
      data['planType'] = this.planType!.toJson();
    }
    data['total'] = this.total;
    data['totalMonthly'] = this.totalMonthly;
    data['flgValueByMonth'] = this.flgValueByMonth;
    data['flgCompromise'] = this.flgCompromise;
    data['compromiseText'] = this.compromiseText;

    return data;
  }

  @override
  String toString() {
    return 'PlansModel(id: $id, name: $name, title: $title, startTime: $startTime, endTime: $endTime, price: $price, numberDependents: $numberDependents, discount: $discount, descriptions: $descriptions, isSingle: $isSingle, canRemoveDependents: $canRemoveDependents, numberAppointments: $numberAppointments, orders: $orders, isSubscription: $isSubscription, flgHighlight: $flgHighlight, months: $months, fine: $fine, delayDays: $delayDays, urlWebView: $urlWebView, specialtys: $specialtys, child: $child, total: $total)';
  }
}

class PlanType {
  int? id;
  String? name;
  SystemCode? systemCode;

  PlanType({this.id, this.name, this.systemCode});

  PlanType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    systemCode = json['systemCode'] != null
        ? new SystemCode.fromJson(json['systemCode'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.systemCode != null) {
      data['systemCode'] = this.systemCode!.toJson();
    }
    return data;
  }
}

class SystemCode {
  int? id;
  String? name;

  SystemCode({this.id, this.name});

  SystemCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
