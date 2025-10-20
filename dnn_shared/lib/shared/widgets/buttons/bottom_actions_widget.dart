import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_dependencies/sc_util.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class BottomActionsWidget extends StatelessWidget {
  const BottomActionsWidget({
    super.key,
    required this.nextPageAction,
    this.backPageAction,
    this.child,
    this.hasNextButton = true,
    this.titleButton,
  });

  final VoidCallback? nextPageAction;
  final VoidCallback? backPageAction;
  final Widget? child;
  final bool? hasNextButton;
  final String? titleButton;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: EdgeInsets.all(5.h),
        child: SizedBox(
          width: Responsive.maxWidth(),
          height: 50.h,
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40.h,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: AppColors.blackLightColor),
                    onPressed: backPageAction ?? () => Get.back(),
                    child: Text(
                      'Voltar',
                      style: Fonts.titleSmall(context)
                          .copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                ),
              ),
              if (hasNextButton!) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 40.h,
                    child: FilledButton(
                      onPressed: nextPageAction,
                      child: child ??
                          Text(
                            titleButton ?? 'Continuar',
                            style: Fonts.titleSmall(context)
                                .copyWith(color: AppColors.whiteColor),
                          ),
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
