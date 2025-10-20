import 'dart:convert';

class GNCreditCard {
  late String number;
  late String brand;
  late String expirationMonth;
  late String expirationYear;
  late String cvv;
  late String salt;

  GNCreditCard({
    required this.number,
    required this.brand,
    required this.expirationMonth,
    required this.expirationYear,
    required this.cvv,
    required this.salt,
  });

  GNCreditCard.fromMap(Map<String, dynamic> map) {
    number = map["number"];
    brand = map["brand"];
    expirationMonth = map["expiration_month"];
    expirationYear = map["expiration_year"];
    cvv = map["cvv"];
    salt = map["salt"];
  }

  String toJson() {
    return jsonEncode({
      "brand": brand,
      "number": number,
      "cvv": cvv,
      "expiration_month": expirationMonth,
      "expiration_year": expirationYear,
      "salt": salt,
    });
  }
}
