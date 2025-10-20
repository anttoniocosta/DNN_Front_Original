// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dnn_core/all_exports.dart';

class CheckoutRequest {
  int? useTermsId;
  int? typePaymentId;
  String? planId;
  String? contractId;
  int? specialtyId;
  int? mercadoPagoId;
  CardModel? card;
  ClientModel? client;
  MercadoPagoRequest? mercadoPago;

  CheckoutRequest(
      {this.useTermsId,
      this.typePaymentId,
      this.planId,
      this.specialtyId,
      this.card,
      this.client,
      this.contractId,
      this.mercadoPago,
      this.mercadoPagoId});

  CheckoutRequest.fromJson(Map<String, dynamic> json) {
    useTermsId = json['useTermsId'];
    typePaymentId = json['typePaymentId'];
    planId = json['planId'];
    specialtyId = json['specialtyId'];
    contractId = json['contractId'];
    mercadoPagoId = json['mercadoPagoId'];
    card = json['card'] != null ? CardModel.fromJson(json['card']) : null;
    mercadoPago = json['mercadoPago'] != null
        ? MercadoPagoRequest.fromJson(json['mercadoPago'])
        : null;
    client =
        json['client'] != null ? ClientModel.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['useTermsId'] = this.useTermsId;
    data['typePaymentId'] = this.typePaymentId;
    data['planId'] = this.planId;
    data['specialtyId'] = this.specialtyId;
    data['mercadoPagoId'] = this.mercadoPagoId;
    data['contractId'] = this.contractId;
    if (this.card != null) {
      data['card'] = this.card!.toJson();
    }
    if (this.mercadoPago != null) {
      data['mercadoPago'] = this.mercadoPago!.toJson();
    }
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'CheckoutRequest(useTermsId: $useTermsId, typePaymentId: $typePaymentId, planId: $planId, specialtyId: $specialtyId, card: $card, client: $client, mercadoPagoId: $mercadoPagoId)';
  }
}

class CardModel {
  String? document;
  String? birth;
  String? holderName;
  String? cardMask;
  String? paymentToken;
  int? installments;
  String? ipAddress;
  bool? recurringPayment;
  String? zipcode;
  String? street;
  String? number;
  String? complement;
  String? neighborhood;
  String? city;
  String? state;

  CardModel(
      {this.document,
      this.birth,
      this.holderName,
      this.cardMask,
      this.paymentToken,
      this.installments,
      this.ipAddress,
      this.recurringPayment,
      this.zipcode,
      this.street,
      this.number,
      this.complement,
      this.neighborhood,
      this.city,
      this.state});

  CardModel.fromJson(Map<String, dynamic> json) {
    document = json['document'];
    birth = json['birth'];
    holderName = json['holderName'];
    cardMask = json['cardMask'];
    paymentToken = json['paymentToken'];
    installments = json['installments'];
    ipAddress = json['ip_address'];
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

  @override
  String toString() {
    return 'CardModel(document: $document, birth: $birth, holderName: $holderName, cardMask: $cardMask, paymentToken: $paymentToken, installments: $installments, ipAddress: $ipAddress, recurringPayment: $recurringPayment, zipcode: $zipcode, street: $street, number: $number, complement: $complement, neighborhood: $neighborhood, city: $city, state: $state)';
  }
}

class ClientModel {
  String? contractId;
  String? document;
  String? name;
  String? birthday;
  String? email;
  String? phoneNumber;
  String? gender;
  String? firebaseToken;
  AddressModel? address;
  String? registrationID;
  int? maritalStatus;

  ClientModel({
    this.contractId,
    this.document,
    this.name,
    this.birthday,
    this.email,
    this.phoneNumber,
    this.gender,
    this.firebaseToken,
    this.address,
    this.registrationID,
    this.maritalStatus,
  });

  ClientModel.fromJson(Map<String, dynamic> json) {
    contractId = json['contractId'];
    document = json['document'];
    name = json['name'];
    birthday = json['birthday'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    firebaseToken = json['firebaseToken'];
    address = json['address'] != null
        ? new AddressModel.fromJson(json['address'])
        : null;
    registrationID = json['registrationID'];
    maritalStatus = json['maritalStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contractId'] = this.contractId;
    data['document'] = this.document;
    data['name'] = this.name;
    data['birthday'] = this.birthday;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['firebaseToken'] = this.firebaseToken;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['registrationID'] = this.registrationID;
    data['maritalStatus'] = this.maritalStatus;
    return data;
  }

  @override
  String toString() {
    return 'ClientModel(contractId: $contractId, document: $document, name: $name, birthday: $birthday, email: $email, phoneNumber: $phoneNumber, gender: $gender, firebaseToken: $firebaseToken, address: $address)';
  }
}

class MercadoPagoRequest {
  String? tokenCard;
  String? clientId;
  int? installments;
  String? paymentMethodId;
  String? issuerId;

  MercadoPagoRequest(
      {this.tokenCard,
      this.clientId,
      this.installments,
      this.paymentMethodId,
      this.issuerId});

  MercadoPagoRequest.fromJson(Map<String, dynamic> json) {
    tokenCard = json['tokenCard'];
    clientId = json['clientId'];
    installments = json['installments'];
    paymentMethodId = json['payment_method_id'];
    issuerId = json['issuer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tokenCard'] = this.tokenCard;
    data['clientId'] = this.clientId;
    data['installments'] = this.installments;
    data['payment_method_id'] = this.paymentMethodId;
    data['issuer_id'] = this.issuerId;
    return data;
  }
}
