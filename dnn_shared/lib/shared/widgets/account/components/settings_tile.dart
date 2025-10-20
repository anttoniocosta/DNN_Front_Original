import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';
import 'package:dnn_shared/dnn_shared.dart';

class SettingsActions extends StatelessWidget {
  const SettingsActions({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color:
              Get.isDarkMode ? AppColors.midBlackColor : AppColors.whiteColor,
          boxShadow: highElevation,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              child: FaIcon(icon, size: 26, color: AppColors.blueColor),
            ),
            10.widthGap,
            Expanded(
              child: Text(title, style: Fonts.titleSmall(context)),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 26,
              color: Get.isDarkMode
                  ? AppColors.whiteColor
                  : AppColors.blackDarkColor,
            )
          ],
        ).paddingSymmetric(vertical: 16, horizontal: 20),
      ),
    ).paddingOnly(bottom: 16);
  }
}
