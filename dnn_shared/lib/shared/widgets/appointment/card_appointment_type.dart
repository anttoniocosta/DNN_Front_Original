import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class CardAppointmentType extends StatelessWidget {
  const CardAppointmentType(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap,
      this.backgroundColor,
      this.isPrincipal = false});
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final bool? isPrincipal;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: AppColors.blackLightColor.withOpacity(0.1),
      radius: radiusMedium,
      borderRadius: BorderRadius.circular(radiusMedium),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:
              Get.isDarkMode ? AppColors.midBlackColor : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(radiusMedium),
          boxShadow: highElevation,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            5.heightGap,
            CardIconWidget(
              cardColor: AppColors.blueColor,
              radius: 12,
              icon: icon,
              iconColor: AppColors.whiteColor,
            ),
            5.heightGap,
            Expanded(
              child: Text(
                title,
                style: Fonts.titleSmall(context).copyWith(
                    color: isPrincipal! ? AppColors.whiteColor : null,
                    height: 1),
                textAlign: TextAlign.center,
              ).toCenter,
            ),
          ],
        ).toCenter,
      ),
    );
  }
}
