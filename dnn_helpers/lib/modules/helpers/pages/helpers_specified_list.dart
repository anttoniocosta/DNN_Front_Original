import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';
import 'package:get/get.dart';

class HelpersSpecifiedList extends StatelessWidget {
  HelpersSpecifiedList({super.key});

  final String tag = Get.arguments['tag'];
  final String title = Get.arguments['title'];
  final List<HelperModel>? childs = Get.arguments['childs'];

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      hasActions: false,
      title: title,
      maxWidth: Responsive.maxWidth(),
      bodyChild: Column(
        children: [
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: childs!.length,
            shrinkWrap: true,
            separatorBuilder: (_, __) => 6.heightGap,
            itemBuilder: (_, index) {
              final e = childs![index];
              return ExpansionTileBuilder(
                helper: e,
                title: title,
              );
            },
          ),
        ],
      ),
    );
  }
}
