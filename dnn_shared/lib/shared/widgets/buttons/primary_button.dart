import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatelessWidget {
  const PrimaryButtonWidget({
    super.key,
    this.titleButtom,
    this.height = 60,
    this.onTap,
    this.child,
    this.isLoading = false,
    this.fontSize,
    this.color,
  });

  final String? titleButtom;
  final double? height;
  final double? fontSize;
  final VoidCallback? onTap;
  final Widget? child;
  final bool? isLoading;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.maxWidth(),
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.blueColor,
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
                    color: AppColors.whiteColor,
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
