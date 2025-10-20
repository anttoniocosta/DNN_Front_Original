import 'package:dnn_dependencies/dnn_dependencies.dart';

class InvoicePaymentDetailsModel {
  String? orderId;
  String? paymentId;
  String? title;
  String? referenceCode;
  String? transactionCode;
  int? number;
  InvoicePaymentState? paymentState;
  InvoicePaymentState? typePayment;
  String? createAt;
  String? updateAt;
  String? paymentAt;
  String? startDate;
  String? endDate;
  double? total;
  bool? isPaid;
  InvoiceInfo? info;
  List<InvoicePersons>? persons;

  InvoicePaymentDetailsModel(
      {this.orderId,
      this.paymentId,
      this.title,
      this.number,
      this.paymentState,
      this.typePayment,
      this.createAt,
      this.updateAt,
      this.paymentAt,
      this.startDate,
      this.endDate,
      this.total,
      this.isPaid,
      this.info,
      this.transactionCode,
      this.referenceCode,
      this.persons});

  static List<InvoicePaymentDetailsModel> recoverList(
      Response<dynamic> response) {
    return (response.data['data'] as List<dynamic>)
        .map((e) => InvoicePaymentDetailsModel.fromJson(e))
        .toList();
  }

  InvoicePaymentDetailsModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    paymentId = json['paymentId'];
    title = json['title'];
    number = json['number'];
    transactionCode = json['transactionCode'];
    referenceCode = json['referenceCode'];
    paymentState = json['paymentState'] != null
        ? new InvoicePaymentState.fromJson(json['paymentState'])
        : null;
    typePayment = json['typePayment'] != null
        ? new InvoicePaymentState.fromJson(json['typePayment'])
        : null;
    createAt = json['createAt'];
    updateAt = json['updateAt'];
    paymentAt = json['paymentAt'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    total = json['total'];
    isPaid = json['isPaid'];
    info = json['info'] != null ? new InvoiceInfo.fromJson(json['info']) : null;
    if (json['persons'] != null) {
      persons = <InvoicePersons>[];
      json['persons'].forEach((v) {
        persons!.add(new InvoicePersons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['paymentId'] = this.paymentId;
    data['title'] = this.title;
    data['number'] = this.number;
    if (this.paymentState != null) {
      data['paymentState'] = this.paymentState!.toJson();
    }
    if (this.typePayment != null) {
      data['typePayment'] = this.typePayment!.toJson();
    }
    data['createAt'] = this.createAt;
    data['updateAt'] = this.updateAt;
    data['paymentAt'] = this.paymentAt;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['total'] = this.total;
    data['transactionCode'] = this.transactionCode;
    data['referenceCode'] = this.referenceCode;
    data['isPaid'] = this.isPaid;
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    if (this.persons != null) {
      data['persons'] = this.persons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InvoicePaymentState {
  int? id;
  String? name;

  InvoicePaymentState({this.id, this.name});

  InvoicePaymentState.fromJson(Map<String, dynamic> json) {
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

class InvoiceInfo {
  InvoicePix? pix;
  InvoiceBillet? billet;

  InvoiceInfo({this.pix, this.billet});

  InvoiceInfo.fromJson(Map<String, dynamic> json) {
    pix = json['pix'] != null ? new InvoicePix.fromJson(json['pix']) : null;
    billet = json['billet'] != null
        ? new InvoiceBillet.fromJson(json['billet'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pix != null) {
      data['pix'] = this.pix!.toJson();
    }
    if (this.billet != null) {
      data['billet'] = this.billet!.toJson();
    }
    return data;
  }
}

class InvoicePix {
  int? locId;
  String? qrcode;

  InvoicePix({this.locId, this.qrcode});

  InvoicePix.fromJson(Map<String, dynamic> json) {
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

class InvoiceBillet {
  String? pdf;
  String? barcode;

  InvoiceBillet({this.pdf, this.barcode});

  InvoiceBillet.fromJson(Map<String, dynamic> json) {
    pdf = json['pdf'];
    barcode = json['barcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pdf'] = this.pdf;
    data['barcode'] = this.barcode;
    return data;
  }
}

class InvoicePersons {
  String? personId;
  String? name;
  String? document;
  String? email;
  double? total;
  bool? isOwner;
  List<Products>? products;

  InvoicePersons(
      {this.personId,
      this.name,
      this.document,
      this.email,
      this.total,
      this.isOwner,
      this.products});

  InvoicePersons.fromJson(Map<String, dynamic> json) {
    personId = json['personId'];
    name = json['name'];
    document = json['document'];
    email = json['email'];
    if (json['total'] == 0) {
      total = 0.00;
    } else {
      total = json['total'];
    }
    isOwner = json['isOwner'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personId'] = this.personId;
    data['name'] = this.name;
    data['document'] = this.document;
    data['email'] = this.email;
    data['total'] = this.total;
    data['isOwner'] = this.isOwner;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? id;
  String? productId;
  String? productName;
  String? title;
  int? number;
  double? price;

  Products(
      {this.id,
      this.productId,
      this.productName,
      this.title,
      this.number,
      this.price});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    productName = json['productName'];
    title = json['title'];
    number = json['number'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['title'] = this.title;
    data['number'] = this.number;
    data['price'] = this.price;
    return data;
  }
}
