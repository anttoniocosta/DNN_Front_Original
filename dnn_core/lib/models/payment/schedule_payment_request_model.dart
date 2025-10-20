import 'package:dnn_core/models/export.dart';

import '../../all_exports.dart';

class SchedulePaymentRequestModel {
  int? useTermsId;
  String? scheduleConsultationId;
  bool? isAnotherPatient;
  PatientModel? patient;
  int? typePaymentId;
  int? mercadoPagoId;
  PaymentCardModel? card;
  MercadoPagoRequest? mercadoPago;

  SchedulePaymentRequestModel(
      {this.useTermsId,
      this.scheduleConsultationId,
      this.isAnotherPatient,
      this.patient,
      this.typePaymentId,
      this.mercadoPagoId,
      this.card,
      this.mercadoPago});

  SchedulePaymentRequestModel.fromJson(Map<String, dynamic> json) {
    useTermsId = json['useTermsId'];
    scheduleConsultationId = json['scheduleConsultationId'];
    isAnotherPatient = json['isAnotherPatient'];
    patient = json['patient'] != null
        ? new PatientModel.fromJson(json['patient'])
        : null;
    typePaymentId = json['typePaymentId'];
    mercadoPagoId = json['mercadoPagoId'];
    card = json['card'] != null
        ? new PaymentCardModel.fromJson(json['card'])
        : null;
    mercadoPago = json['mercadoPago'] != null
        ? new MercadoPagoRequest.fromJson(json['mercadoPago'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['useTermsId'] = this.useTermsId;
    data['scheduleConsultationId'] = this.scheduleConsultationId;
    data['isAnotherPatient'] = this.isAnotherPatient;
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    } else {
      data['patient'] = null;
    }
    data['typePaymentId'] = this.typePaymentId;
    data['mercadoPagoId'] = this.mercadoPagoId;
    if (this.card != null) {
      data['card'] = this.card!.toJson();
    } else {
      data['card'] = null;
    }
    if (this.mercadoPago != null) {
      data['mercadoPago'] = this.mercadoPago!.toJson();
    }
    return data;
  }
}

class PatientModel {
  String? document;
  String? name;
  String? birthday;
  String? email;
  String? phoneNumber;
  String? gender;
  String? registrationID;
  int? maritalStatus;
  AddressModel? address;

  PatientModel(
      {this.document,
      this.name,
      this.birthday,
      this.email,
      this.phoneNumber,
      this.gender,
      this.registrationID,
      this.maritalStatus,
      this.address});

  PatientModel.fromProvider(AccountRequestModel model)
      : this(
          document: model.document,
          name: model.name,
          birthday: model.birthday,
          email: model.email,
          phoneNumber: model.phoneNumber,
          gender: model.gender,
          registrationID: model.registrationID,
          maritalStatus: model.maritalStatus,
          address: model.address!,
        );

  PatientModel.fromJson(Map<String, dynamic> json) {
    document = json['document'];
    name = json['name'];
    birthday = json['birthday'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    registrationID = json['registrationID'];
    maritalStatus = json['maritalStatus'];
    address = json['address'] != null
        ? new AddressModel.fromJson(json['address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document'] = this.document;
    data['name'] = this.name;
    data['birthday'] = this.birthday;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['registrationID'] = this.registrationID;
    data['maritalStatus'] = this.maritalStatus;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}
