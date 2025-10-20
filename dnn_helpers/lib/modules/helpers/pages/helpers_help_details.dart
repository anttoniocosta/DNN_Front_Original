import 'package:flutter/material.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:get/get.dart';

class HelpersHelpDetails extends StatelessWidget {
  HelpersHelpDetails({super.key});

  final String tag = Get.arguments['tag'];
  final String title = Get.arguments['title'];
  final HelperModel helper = Get.arguments['helper'];

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      hasActions: false,
      maxWidth: Responsive.maxWidth(),
      title: title,
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          10.heightGap,
          Text(helper.name!, style: Fonts.titleLarge(context)),
          10.heightGap,
          Text(helper.descriptions!, style: Fonts.bodyMedium(context)),
          20.heightGap,
        ],
      ),
    );
  }
}
