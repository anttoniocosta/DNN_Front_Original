import 'package:flutter/material.dart';

import '../../../dnn_shared.dart';

class TryAgainPage extends StatelessWidget {
  const TryAgainPage({
    super.key,
    required this.message,
    required this.onTryAgain,
    this.buttonTitle,
  });

  final String message;
  final VoidCallback onTryAgain;
  final String? buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(MediaRes.failPaymentImg),
                10.heightGap,
                Text(
                  message,
                  style: Fonts.displaySmall(context),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        10.heightGap,
        FilledButton.tonal(
          onPressed: onTryAgain,
          child: Text(
            buttonTitle ?? 'Tente novamente',
            style:
                Fonts.titleSmall(context).copyWith(color: AppColors.whiteColor),
          ),
        )
      ],
    );
  }
}
