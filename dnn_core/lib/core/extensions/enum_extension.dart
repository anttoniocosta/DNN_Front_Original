import 'package:flutter_credit_card/flutter_credit_card.dart';

extension EnumExtension on Enum {
  String getBrandName() {
    switch (this) {
      case CardType.mastercard:
        return 'mastercard';
      case CardType.visa:
        return 'visa';
      case CardType.americanExpress:
        return 'amex';
      case CardType.elo:
        return 'elo';
      case CardType.hipercard:
        return 'hipercard';
      default:
        return 'other';
    }
  }
}
