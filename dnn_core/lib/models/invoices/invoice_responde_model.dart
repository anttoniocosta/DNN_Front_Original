import 'package:dnn_dependencies/dnn_dependencies.dart';

class InvoiceResponseModel {
  String? orderId;
  int? code;
  InvoicePersonModel? holder;
  int? useTermId;
  String? createAt;
  String? updateAt;
  String? startDate;
  String? endDate;
  String? blockedAt;
  String? cancelationAt;
  bool? canSeeInvoices;
  bool? isPaymentValid;
  List<InvoicePersonModel>? dependents;
  String? productId;
  String? productName;

  InvoiceResponseModel(
      {this.orderId,
      this.code,
      this.holder,
      this.useTermId,
      this.createAt,
      this.updateAt,
      this.startDate,
      this.endDate,
      this.canSeeInvoices,
      this.isPaymentValid,
      this.productId,
      this.productName,
      this.cancelationAt,
      this.blockedAt,
      this.dependents});

  static List<InvoiceResponseModel> recoverList(Response<dynamic> response) {
    return (response.data['data'] as List<dynamic>)
        .map((e) => InvoiceResponseModel.fromJson(e))
        .toList();
  }

  InvoiceResponseModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    code = json['code'];
    holder = json['holder'] != null
        ? new InvoicePersonModel.fromJson(json['holder'])
        : null;
    useTermId = json['useTermId'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    productName = json['productName'];
    productId = json['productId'];
    canSeeInvoices = json['canSeeInvoices'];
    isPaymentValid = json['isPaymentValid'];
    cancelationAt = json['cancelationAt'];
    blockedAt = json['blockedAt'];
    if (json['dependents'] != null) {
      dependents = <InvoicePersonModel>[];
      json['dependents'].forEach((v) {
        dependents!.add(new InvoicePersonModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['code'] = this.code;
    if (this.holder != null) {
      data['holder'] = this.holder!.toJson();
    }
    data['useTermId'] = this.useTermId;
    data['createAt'] = this.createAt;
    data['updateAt'] = this.updateAt;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['canSeeInvoices'] = this.canSeeInvoices;
    data['isPaymentValid'] = this.isPaymentValid;
    data['productName'] = this.productName;
    data['productId'] = this.productId;
    data['cancelationAt'] = this.cancelationAt;
    data['blockedAt'] = this.blockedAt;
    if (this.dependents != null) {
      data['dependents'] = this.dependents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InvoicePersonModel {
  String? personId;
  String? name;
  String? email;
  String? phoneNumber;
  String? document;
  String? photoProfile;
  String? birthday;
  String? gender;
  int? age;
  bool? canOpenRapidoc;
  bool? isOwner;

  InvoicePersonModel(
      {this.personId,
      this.name,
      this.email,
      this.phoneNumber,
      this.photoProfile,
      this.document,
      this.birthday,
      this.gender,
      this.age,
      this.isOwner,
      this.canOpenRapidoc});

  InvoicePersonModel.fromJson(Map<String, dynamic> json) {
    personId = json['personId'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    photoProfile = json['photoProfile'];
    document = json['document'];
    canOpenRapidoc = json['canOpenRapidoc'];
    birthday = json['birthday'];
    gender = json['gender'];
    isOwner = json['isOwner'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personId'] = this.personId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['photoProfile'] = this.photoProfile;
    data['document'] = this.document;
    data['canOpenRapidoc'] = this.canOpenRapidoc;
    data['birthday'] = this.birthday;
    data['gender'] = this.gender;
    data['isOwner'] = this.isOwner;
    data['age'] = this.age;
    return data;
  }
}
