import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

Widget buyPlanCard({required String title, bool isPrincipal = false}) {
  return GetBuilder<NavigationController>(
    builder: (_) => CardTabsHome(
      isPrincipal: isPrincipal,
      title: title,
      icon: FontAwesomeIcons.kitMedical,
      onTap: () {
        Get.toNamed(Routes.campaignMainOffers);
      },
    ),
  );
}

class CardTabsHome extends StatelessWidget {
  const CardTabsHome(
      {super.key,
      required this.title,
      this.icon,
      this.imageSrc,
      this.svgSrc,
      required this.onTap,
      this.backgroundColor,
      this.isPrincipal = false});
  final String title;
  final IconData? icon;
  final String? imageSrc;
  final String? svgSrc;
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
            color: backgroundColor ??
                (isPrincipal!
                    ? AppColors.blueColor
                    : (Get.isDarkMode
                        ? AppColors.blackLightColor
                        : AppColors.backgroundCardHomeColor)),
            borderRadius: BorderRadius.circular(radiusMedium),
            boxShadow: highElevation,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              5.heightGap,
              icon != null
                  ? CardIconWidget(
                      cardColor: _cardColor(),
                      radius: 12,
                      icon: icon!,
                      iconColor: Get.isDarkMode
                          ? (isPrincipal!
                              ? AppColors.midBlackColor
                              : AppColors.whiteColor)
                          : (isPrincipal!
                              ? AppColors.blackDarkColor
                              : AppColors.blueColor),
                    )
                  : Container(),
              imageSrc != null
                  ? Image.asset(
                      imageSrc!,
                      width: 50,
                      height: 50,
                    )
                  : Container(),
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
        ));
  }

  _cardColor() {
    if (Get.isDarkMode) {
      return (isPrincipal!
          ? AppColors.lighterGreyColor
          : AppColors.midBlackColor);
    }
    return AppColors.whiteColor;
  }
}
