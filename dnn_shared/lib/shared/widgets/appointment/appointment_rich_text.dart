import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/res/exports.dart';
import 'package:flutter/material.dart';

class AppointmentRichText extends StatelessWidget {
  const AppointmentRichText({
    super.key,
    required this.title,
    required this.content,
    this.isSelected = false,
    this.color,
  });

  final String title;
  final String content;
  final bool? isSelected;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$title: ',
            style: Fonts.bodyMedium(Get.context!).copyWith(
                color:
                    color ?? (isSelected == true ? AppColors.whiteColor : null),
                height: 1.1),
          ),
          TextSpan(
            text: content,
            style: Fonts.bodyMedium(Get.context!).copyWith(
                color:
                    color ?? (isSelected == true ? AppColors.whiteColor : null),
                height: 1.1,fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
