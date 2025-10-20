import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class SecondaryButtonWidget extends StatelessWidget {
  const SecondaryButtonWidget({
    super.key,
    this.titleButtom,
    this.height = 60,
    this.onTap,
    this.child,
    this.fontSize,
    this.isLoading = false,
  });

  final String? titleButtom;
  final double? height;
  final VoidCallback? onTap;
  final Widget? child;
  final double? fontSize;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(Responsive.maxWidth(), height!),
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
          side: const BorderSide(
            color: AppColors.blueColor,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: !isLoading! ? onTap : null,
        child: !isLoading!
            ? child ??
                Text(
                  titleButtom!,
                  style: Fonts.titleMedium(context).copyWith(
                    fontSize: fontSize,
                    fontWeight: FontWeight.normal,
                    fontFamily: Fonts.poppins,
                  ),
                  textAlign: TextAlign.center,
                )
            : const LoadingButtonChildWidget(),
      ),
    );
  }
}
