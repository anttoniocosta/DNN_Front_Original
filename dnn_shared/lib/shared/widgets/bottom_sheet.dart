import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class AppBottomSheet {
  final Widget? content;
  final double? height;
  final bool? isScroll;

  AppBottomSheet({this.content, this.height, this.isScroll = false});

  show(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: AppColors.defaultBackgroundCardColor,
        isScrollControlled: isScroll ?? false,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        builder: (ctx) {
          return SizedBox(
            height: height ?? MediaQuery.of(context).size.height * 0.5,
            child: content,
          );
        });
  }
}
