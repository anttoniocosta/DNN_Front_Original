import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import '../../../dnn_shared.dart';

class ConfirmChoicePartial extends StatelessWidget {
  const ConfirmChoicePartial({
    super.key,
    required this.textToConfirm,
    required this.onConfirm,
    required this.onReject,
    this.isLoading = false,
  });

  final String textToConfirm;
  final VoidCallback onConfirm;
  final VoidCallback onReject;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          textToConfirm,
          style: Fonts.headlineMedium(context).copyWith(
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ).paddingSymmetric(horizontal: 10),
        16.heightGap,
        Row(
          children: [
            Expanded(
              child: SecondaryButtonWidget(
                isLoading: isLoading,
                onTap: onConfirm,
                titleButtom: 'Sim',
              ),
            ),
            16.widthGap,
            Expanded(
              child: PrimaryButtonWidget(
                onTap: isLoading! ? null : onReject,
                titleButtom: 'Não',
              ),
            ),
          ],
        )
      ],
    );
  }
}
