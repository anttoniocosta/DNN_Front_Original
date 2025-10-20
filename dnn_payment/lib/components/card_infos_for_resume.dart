import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class CardInfosForResume extends StatelessWidget {
  const CardInfosForResume({
    super.key,
    required this.issuer,
    required this.lastFourDigits,
  });

  final String issuer;
  final String lastFourDigits;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Cartão de crédito escolhido', style: Fonts.titleLarge(context)),
        5.heightGap,
        Row(
          children: [
            Image.asset(issuer.creditCardIssuer(), height: 28),
            10.widthGap,
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$issuer ',
                    style: Fonts.titleMedium(context),
                  ),
                  const TextSpan(text: '***** '),
                  TextSpan(
                    text: lastFourDigits,
                    style: Fonts.titleMedium(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
