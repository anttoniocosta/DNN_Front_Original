import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class FilterChipsCustom extends StatelessWidget {
  const FilterChipsCustom(
      {super.key,
      required this.chip,
      required this.onTap,
      required this.index});

  final int index;
  final FilterChipsModel chip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          color: index == chip.index
              ? AppColors.blueColor
              : (Get.isDarkMode
                  ? AppColors.lighterblackLightColor
                  : AppColors.lightBlueGreyColor),
          borderRadius: BorderRadius.circular(50),
          boxShadow: highElevation + highElevationTwo,
        ),
        child: Text(
          chip.title,
          style: Fonts.bodyLarge(context).copyWith(
              fontWeight: Fonts.bold,
              fontSize: 16,
              color: index == chip.index
                  ? AppColors.whiteColor
                  : AppColors.secondaryTextColor),
        ),
      ),
    );
  }
}
