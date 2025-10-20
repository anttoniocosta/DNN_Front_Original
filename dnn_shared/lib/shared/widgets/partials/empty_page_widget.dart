import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import '../../../dnn_shared.dart';

class EmptyPageWidget extends StatelessWidget {
  final String title;
  final double? fontSize;
  final Widget? complementWidget;

  const EmptyPageWidget({
    super.key,
    required this.title,
    this.fontSize,
    this.complementWidget = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          MediaRes.emptyErrorImg,
          width: 250,
        ),
        10.heightGap,
        Text(
          title,
          style: Fonts.displaySmall(context).copyWith(fontSize: fontSize),
          textAlign: TextAlign.center,
        ),
        complementWidget!,
      ],
    ).paddingSymmetric(horizontal: 20).toCenter;
  }
}
