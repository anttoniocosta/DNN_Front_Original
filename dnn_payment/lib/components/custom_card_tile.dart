import 'package:dnn_dependencies/sc_util.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class CustomCreditCardTile extends CCardWidget {
  const CustomCreditCardTile({
    super.key,
    required super.issuer,
    required super.lastFourDigits,
    required super.onTap,
    required super.holder,
    required super.removeOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClickableBaseTile(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical:
                      Responsive.doubleSizes(mobile: 6, tablet: 2, desktop: 2)),
              child: Row(
                children: [
                  10.widthGap,
                  Image.asset(
                    issuer.creditCardIssuer(),
                    width: 50,
                    fit: BoxFit.contain,
                  ),
                  22.widthGap,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '$issuer ',
                                style: Fonts.titleSmall(context),
                              ),
                              TextSpan(
                                  text: '***** ',
                                  style: Fonts.bodyLarge(context)),
                              TextSpan(
                                text: lastFourDigits,
                                style: Fonts.titleSmall(context),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Titular: $holder',
                          style: Fonts.bodySmall(context),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: removeOnTap,
              icon: FaIcon(
                FontAwesomeIcons.circleXmark,
                color: AppColors.redColor,
                size: Responsive.doubleSizes(
                    mobile: 20.h, tablet: 24, desktop: 24),
              ),
            ),
          )
        ],
      ),
    );
  }
}
