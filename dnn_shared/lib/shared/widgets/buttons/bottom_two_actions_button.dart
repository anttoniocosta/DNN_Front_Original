import 'package:flutter/material.dart';

import '../../../dnn_shared.dart';

class BottomTwoActionsButton extends StatelessWidget {
  const BottomTwoActionsButton({
    super.key,
    required this.onTapSecond,
    required this.titleSecond,
    this.isLoadingSecond = false,
    this.needHzPadding = true,
    this.needVtPadding = true,
    this.onTapFirst,
    this.titleFirst,
    this.isLoadingFirst = false,
    this.onTapThird,
    this.titleThird,
    this.isLoadingThird = false,
    this.showSecond = true,
  });

  final VoidCallback? onTapSecond;
  final String? titleSecond;
  final bool? isLoadingSecond;
  final VoidCallback? onTapFirst;
  final String? titleFirst;
  final bool? isLoadingFirst;
  final VoidCallback? onTapThird;
  final String? titleThird;
  final bool? isLoadingThird;
  final bool? needHzPadding;
  final bool? needVtPadding;
  final bool? showSecond;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: needHzPadding! ? 20 : 0,
            vertical: needVtPadding! ? 15 : 0),
        child: SizedBox(
          width: Responsive.maxWidth(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SecondaryButtonWidget(
                onTap: !isLoadingFirst! ? onTapFirst : null,
                titleButtom: !isLoadingFirst! ? titleFirst : null,
                child:
                    !isLoadingFirst! ? null : const LoadingButtonChildWidget(),
              ),
              6.heightGap,
              PrimaryButtonWidget(
                color: AppColors.dangerColor,
                onTap: !isLoadingThird! ? onTapThird : null,
                titleButtom: !isLoadingThird! ? titleThird : null,
                child:
                    !isLoadingThird! ? null : const LoadingButtonChildWidget(),
              ),
              if (showSecond!) ...[
                6.heightGap,
                PrimaryButtonWidget(
                  onTap: !isLoadingSecond! ? onTapSecond : null,
                  titleButtom: !isLoadingSecond! ? titleSecond : null,
                  child: !isLoadingSecond!
                      ? null
                      : const LoadingButtonChildWidget(),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
