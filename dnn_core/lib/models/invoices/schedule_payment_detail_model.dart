class SchedulePaymentDetailsModel {
  String? scheduleConsultationId;
  String? paymentId;
  String? referenceCode;
  String? transactionCode;
  PaymentState? paymentState;
  PaymentState? typePayment;
  String? createAt;
  String? updateAt;
  String? paymentAt;
  double? total;
  bool? isPaid;
  Info? info;
  Person? person;

  SchedulePaymentDetailsModel(
      {this.scheduleConsultationId,
      this.paymentId,
      this.referenceCode,
      this.transactionCode,
      this.paymentState,
      this.typePayment,
      this.createAt,
      this.updateAt,
      this.paymentAt,
      this.total,
      this.isPaid,
      this.info,
      this.person});

  SchedulePaymentDetailsModel.fromJson(Map<String, dynamic> json) {
    scheduleConsultationId = json['scheduleConsultationId'];
    paymentId = json['paymentId'];
    referenceCode = json['referenceCode'];
    transactionCode = json['transactionCode'];
    paymentState = json['paymentState'] != null
        ? new PaymentState.fromJson(json['paymentState'])
        : null;
    typePayment = json['typePayment'] != null
        ? new PaymentState.fromJson(json['typePayment'])
        : null;
    createAt = json['createAt'];
    updateAt = json['updateAt'];
    paymentAt = json['paymentAt'];
    total = json['total'];
    isPaid = json['isPaid'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    person =
        json['person'] != null ? new Person.fromJson(json['person']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheduleConsultationId'] = this.scheduleConsultationId;
    data['paymentId'] = this.paymentId;
    data['referenceCode'] = this.referenceCode;
    data['transactionCode'] = this.transactionCode;
    if (this.paymentState != null) {
      data['paymentState'] = this.paymentState!.toJson();
    }
    if (this.typePayment != null) {
      data['typePayment'] = this.typePayment!.toJson();
    }
    data['createAt'] = this.createAt;
    data['updateAt'] = this.updateAt;
    data['paymentAt'] = this.paymentAt;
    data['total'] = this.total;
    data['isPaid'] = this.isPaid;
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    if (this.person != null) {
      data['person'] = this.person!.toJson();
    }
    return data;
  }
}

class PaymentState {
  int? id;
  String? name;

  PaymentState({this.id, this.name});

  PaymentState.fromJson(Map<String, dynamic> json) {
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

class Info {
  Pix? pix;
  Billet? billet;

  Info({this.pix, this.billet});

  Info.fromJson(Map<String, dynamic> json) {
    pix = json['pix'] != null ? new Pix.fromJson(json['pix']) : null;
    billet =
        json['billet'] != null ? new Billet.fromJson(json['billet']) : null;
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

class Pix {
  int? locId;
  String? qrcode;

  Pix({this.locId, this.qrcode});

  Pix.fromJson(Map<String, dynamic> json) {
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

class Billet {
  String? pdf;
  String? barcode;

  Billet({this.pdf, this.barcode});

  Billet.fromJson(Map<String, dynamic> json) {
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

class Person {
  String? personId;
  String? name;
  String? document;
  String? email;

  Person({this.personId, this.name, this.document, this.email});

  Person.fromJson(Map<String, dynamic> json) {
    personId = json['personId'];
    name = json['name'];
    document = json['document'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personId'] = this.personId;
    data['name'] = this.name;
    data['document'] = this.document;
    data['email'] = this.email;
    return data;
  }
}
