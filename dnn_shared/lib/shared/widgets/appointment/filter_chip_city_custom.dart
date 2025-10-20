import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class FilterChipCityCustom extends StatelessWidget {
  const FilterChipCityCustom({
    super.key,
    required this.title,
    required this.onTap,
    required this.onDelete,
  });

  final String title;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        color: (Get.isDarkMode
            ? AppColors.lighterblackLightColor
            : AppColors.whiteColor),
        borderRadius: BorderRadius.circular(50),
        boxShadow: highElevation,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onTap,
            child: Text(
              'Cidade: $title',
              style: Fonts.bodyLarge(context).copyWith(
                fontWeight: Fonts.light,
                overflow: TextOverflow.ellipsis,
              ),
            ).paddingSymmetric(vertical: 3),
          ),
          20.widthGap,
          SizedBox(
            width: 30,
            height: 20,
            child: InkWell(
              onTap: onDelete,
              child: FaIcon(
                FontAwesomeIcons.xmark,
                size: 16,
                color: (!Get.isDarkMode
                    ? AppColors.midBlackColor
                    : AppColors.whiteColor),
              ),
            ).toCenter,
          ).paddingOnly(left: 10)
        ],
      ),
    );
  }
}
