import 'package:dnn_core/all_exports.dart';
import 'package:dnn_core/core/encrypt/aes_helper.dart';

class CardResponse {
  String? id;
  String? holderName;
  String? document;
  String? cardNumber;
  String? cardNumberMask;
  String? expirationMonth;
  String? expirationYear;
  String? birthDate;
  String? issuer;
  String? brand;
  String? code;

  String get lastFourDigits => cardNumber!.getLasFourDigits();

  String get firstSixDigits => cardNumber!.substring(0, 6);
  CardResponse({
    this.id,
    this.holderName,
    this.document,
    this.cardNumber,
    this.cardNumberMask,
    this.expirationMonth,
    this.expirationYear,
    this.issuer,
    this.birthDate,
    this.code,
    this.brand,
  });

  CardResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    holderName = json['holderName'];
    document = json['document'];
    cardNumber = json['cardNumber'];
    cardNumberMask = json['cardNumberMask'];
    expirationMonth = json['expirationMonth'];
    expirationYear = json['expirationYear'];
    issuer = json['issuer'];
    birthDate = json['birthDate'];
    brand = json['brand'];
    code = json['code'];
  }

  CardResponse decrypt() {
    return CardResponse(
      id: id,
      holderName: AesHelper.decrypt(holderName!),
      document: AesHelper.decrypt(document!),
      cardNumber: AesHelper.decrypt(cardNumber!).replaceAll(' ', ''),
      cardNumberMask: AesHelper.decrypt(cardNumberMask!),
      expirationMonth: AesHelper.decrypt(expirationMonth!),
      expirationYear: AesHelper.decrypt(expirationYear!),
      issuer: AesHelper.decrypt(issuer!),
      brand: AesHelper.decrypt(brand!),
      birthDate: AesHelper.decrypt(birthDate!),
    );
  }

  CardResponse encrypt() {
    return CardResponse(
      id: null,
      holderName: AesHelper.encrypt(holderName!),
      document: AesHelper.encrypt(document!),
      cardNumber: AesHelper.encrypt(cardNumber!),
      cardNumberMask: AesHelper.encrypt(cardNumberMask!),
      expirationMonth: AesHelper.encrypt(expirationMonth!),
      expirationYear: AesHelper.encrypt(expirationYear!),
      issuer: AesHelper.encrypt(brand!),
      brand: AesHelper.encrypt(brand!),
      birthDate: AesHelper.encrypt(birthDate!),
      code: AesHelper.encrypt(code!),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['holderName'] = this.holderName;
    data['document'] = this.document;
    data['cardNumber'] = this.cardNumber;
    data['cardNumberMask'] = this.cardNumberMask;
    data['expirationMonth'] = this.expirationMonth;
    data['expirationYear'] = this.expirationYear;
    data['issuer'] = this.issuer;
    data['brand'] = this.brand;
    data['birthDate'] = this.birthDate;
    data['code'] = this.code;
    return data;
  }
}
