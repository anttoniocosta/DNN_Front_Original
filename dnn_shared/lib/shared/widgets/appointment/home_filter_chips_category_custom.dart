import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/shared/viewmodels/home_filter_chip_category_model.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class HomeFilterChipsCategoryCustom extends StatelessWidget {
  final int index;
  final HomeFilterChipsCategoryModel chip;
  final bool isSelected;
  final ValueChanged<int>? onTap;

  const HomeFilterChipsCategoryCustom({
    super.key,
    required this.index,
    required this.chip,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () => onTap!(chip.index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.blueColor
              : (Get.isDarkMode
                  ? AppColors.lighterblackLightColor
                  : AppColors.defaultBackgroundCardColor),
          borderRadius: BorderRadius.circular(50),
          boxShadow: highElevation + highElevationTwo,
        ),
        child: Text(
          chip.title,
          style: Fonts.bodyLarge(context).copyWith(
            fontWeight: Fonts.light,
            color: isSelected ? AppColors.whiteColor : null,
          ),
        ),
      ),
    );
  }
}
