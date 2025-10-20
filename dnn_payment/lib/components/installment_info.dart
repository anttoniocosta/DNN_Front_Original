import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class InstallmentInfo extends StatelessWidget {
  const InstallmentInfo({
    super.key,
    required this.installment,
    required this.amount,
  });

  final int installment;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${installment}x ',
                style: Fonts.titleLarge(context),
              ),
              TextSpan(
                text: amount.formatReal(),
                style: Fonts.bodyLarge(context),
              )
            ],
          ),
        ),
        const Spacer(),
        if (installment > 1)
          Text(
            '(c/ juros)',
            style: Fonts.bodySmall(context),
            textAlign: TextAlign.end,
          ),
        6.widthGap,
        Text(
          (amount * installment).formatReal(),
          style: Fonts.titleLarge(context).copyWith(color: AppColors.blueColor),
        ),
      ],
    );
  }
}
