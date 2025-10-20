import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class AvaiableHourTile extends StatelessWidget {
  const AvaiableHourTile({
    super.key,
    required this.hour,
    required this.price,
    this.isSelected = false,
    this.onTap,
    this.centerText,
  });

  final String hour;
  final double price;
  final bool? isSelected;
  final VoidCallback? onTap;
  final String? centerText;

  @override
  Widget build(BuildContext context) {
    return SearchResultTile(
      bgColor: isSelected!
          ? Get.isDarkMode
              ? AppColors.lighterblackLightColor
              : AppColors.blackDarkColor
          : null,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(hour,
              style: Fonts.titleSmall(Get.context!).copyWith(
                color: isSelected! ? AppColors.whiteColor : null,
              )),
          Text(centerText!,
              style: Fonts.bodyLarge(Get.context!).copyWith(
                overflow: TextOverflow.ellipsis,
                color: isSelected! ? AppColors.whiteColor : null,
              )),
          Text(
            price.formatReal(),
            style: Fonts.titleSmall(Get.context!).copyWith(
                color: isSelected! ? AppColors.whiteColor : null, height: 0.8),
          ),
        ],
      ),
    );
  }
}
