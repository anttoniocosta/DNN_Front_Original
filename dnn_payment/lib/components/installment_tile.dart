import 'package:dnn_dependencies/sc_util.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class InstallmentTile extends StatelessWidget {
  const InstallmentTile({
    super.key,
    required this.onTap,
    required this.installment,
    required this.amount,
  });

  final VoidCallback onTap;
  final int installment;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: installment > 1
          ? Text(
              '(c/ juros)',
              style: Fonts.bodySmall(context),
              textAlign: TextAlign.end,
            )
          : null,
      horizontalTitleGap: 10.h,
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
      leading: Text.rich(
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
      trailing: Text(
        (amount * installment).formatReal(),
        style: Fonts.titleLarge(context),
      ),
    );
  }
}
