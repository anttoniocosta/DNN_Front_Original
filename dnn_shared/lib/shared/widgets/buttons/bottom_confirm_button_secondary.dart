import 'package:dnn_dependencies/sc_util.dart';
import 'package:flutter/material.dart';

import '../../../dnn_shared.dart';

class BottomConfirmButtonSecondary extends StatelessWidget {
  const BottomConfirmButtonSecondary({
    super.key,
    required this.onTap,
    required this.title,
    this.isLoading = false,
    this.needHzPadding = true,
  });

  final VoidCallback? onTap;
  final String? title;
  final bool? isLoading;
  final bool? needHzPadding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: needHzPadding! ? 20.h : 0, vertical: 15.h),
        child: SizedBox(
          width: Responsive.maxWidth(),
          child: SecondaryButtonWidget(
            height: Responsive.doubleSizes(mobile: 50, tablet: 55, desktop: 50),
            onTap: !isLoading! ? onTap : null,
            titleButtom: !isLoading! ? title : null,
            child: !isLoading! ? null : const LoadingButtonChildWidget(),
          ),
        ),
      ),
    );
  }
}
