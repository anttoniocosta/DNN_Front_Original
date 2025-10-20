import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class HourScheduledTile extends StatelessWidget {
  const HourScheduledTile({
    super.key,
    required this.hour,
    required this.typeScheduled,
    required this.price,
    this.isSelected = false,
    this.onTap,
    this.disabled = false,
  });

  final String hour;
  final String typeScheduled;
  final double price;
  final bool? isSelected;
  final VoidCallback? onTap;
  final bool? disabled;

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
                color: disabled!
                    ? AppColors.greyColor
                    : isSelected!
                        ? AppColors.whiteColor
                        : null,
              )),
          Text(typeScheduled,
              style: Fonts.bodyLarge(Get.context!).copyWith(
                overflow: TextOverflow.ellipsis,
                color: disabled!
                    ? AppColors.greyColor
                    : isSelected!
                        ? AppColors.whiteColor
                        : null,
              )),
          Text(
            price.formatReal(),
            style: Fonts.titleSmall(Get.context!).copyWith(
                color: disabled!
                    ? AppColors.greyColor
                    : isSelected!
                        ? AppColors.whiteColor
                        : null,
                height: 0.8),
          ),
        ],
      ),
    );
  }
}
