import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/res/exports.dart';
import 'package:flutter/material.dart';

class AppointmentDivider extends StatelessWidget {
  const AppointmentDivider({
    super.key,
    required this.isSelected,
  });

  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: isSelected == true
          ? AppColors.whiteColor
          : !Get.isDarkMode
              ? AppColors.blackDarkColor
              : AppColors.whiteColor,
    );
  }
}
