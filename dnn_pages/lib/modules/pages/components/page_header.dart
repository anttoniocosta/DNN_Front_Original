import 'package:dnn_pages/dnn_pages.dart';
import 'package:dnn_shared/res/typography/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({Key? key, required this.pgEnum, this.textStyle})
      : super(key: key);

  final String pgEnum;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PagesController>(builder: (_) {
      return HtmlWidget(
        pagesController.currentPage(pgEnum)?.content ?? '',
        textStyle: textStyle ??
            Fonts.bodyLarge(context).copyWith(
              overflow: TextOverflow.ellipsis,
              fontSize: 15,
              fontFamily: Fonts.poppins,
            ),
      );
    });
  }
}
