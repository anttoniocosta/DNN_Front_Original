import 'package:flutter/material.dart';

import '../../../dnn_shared.dart';

class BottomConfirmButton extends StatelessWidget {
  const BottomConfirmButton({
    super.key,
    required this.onTap,
    required this.title,
    this.isLoading = false,
    this.needHzPadding = true,
    this.needVtPadding = true,
  });

  final VoidCallback? onTap;
  final String? title;
  final bool? isLoading;
  final bool? needHzPadding;
  final bool? needVtPadding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: needHzPadding! ? 20 : 0,
            vertical: needVtPadding! ? 15 : 0),
        child: SizedBox(
          width: 1000,
          child: PrimaryButtonWidget(
            onTap: !isLoading! ? onTap : null,
            titleButtom: !isLoading! ? title : null,
            child: !isLoading! ? null : const LoadingButtonChildWidget(),
          ),
        ),
      ),
    );
  }
}
