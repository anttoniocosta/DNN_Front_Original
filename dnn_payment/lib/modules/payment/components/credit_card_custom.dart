import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CreditCardCustom extends StatelessWidget {
  const CreditCardCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreditCardController>(
      builder: (_) {
        return CreditCardWidget(
          height: Responsive.doubleSizes(
              small: 200, mobile: 200, tablet: 220.0, desktop: 240.0),
          padding: 0,
          glassmorphismConfig: null,
          cardNumber: _.cardNumber,
          expiryDate: _.expiryDate,
          cardHolderName: _.cardHolderName,
          cvvCode: _.cvvCode,
          bankName: 'DNN',
          frontCardBorder: null,
          backCardBorder: null,
          showBackView: _.isCvvFocused,
          labelCardHolder: 'NOME IMPRESSO',
          labelValidThru: 'VALIDO\nATÉ',
          labelExpiredDate: '00/00',
          obscureCardNumber: false,
          obscureCardCvv: false,
          isHolderNameVisible: true,
          isSwipeGestureEnabled: true,
          chipColor: Colors.amber[300],
          cardBgColor: Get.isDarkMode ? AppColors.blackDarkColor : Colors.black,
          onCreditCardWidgetChange: (creditCardBrand) {
            _.brand = creditCardBrand.brandName!.getBrandName();
          },
        );
      },
    );
  }
}
