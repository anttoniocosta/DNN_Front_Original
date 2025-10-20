import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class BottomItem extends StatelessWidget {
  const BottomItem({
    super.key,
    required this.index,
    required this.icon,
    this.isBackPage = false,
  });

  final int index;
  final IconData icon;
  final bool isBackPage;

  bgColorLigh() {
    if (themeController.isDark.value) return Colors.lightBlue[600];
    return AppColors.blackLightColor;
  }

  bgColorDark() {
    if (themeController.isDark.value) return AppColors.blackLightColor;
    return AppColors.blueColor;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          if (isBackPage) {
            Navigator.of(context).pop();
          }

          navigationController.navigatePageView(index);
        },
        child: Obx(() {
          return Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: Align(
              alignment: Alignment.center,
              child: FittedBox(
                child: FaIcon(
                  icon,
                  color: navigationController.currentIndex == index
                      ? (isBackPage
                          ? AppColors.blueColor
                          : AppColors.whiteColor)
                      : AppColors.blueColor,
                  size: Responsive.doubleSizes(
                      mobile: 25, tablet: 25, desktop: 25),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class CustomBottomItem extends StatelessWidget {
  const CustomBottomItem({
    super.key,
    required this.index,
    required this.icon,
    this.isBackPage = false,
  });

  final int index;
  final String icon;
  final bool isBackPage;

  bgColorLigh() {
    if (themeController.isDark.value) return Colors.lightBlue[600];
    return AppColors.blackLightColor;
  }

  bgColorDark() {
    if (themeController.isDark.value) return AppColors.blackLightColor;
    return AppColors.blueColor;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          if (isBackPage) {
            Get.back();
            Get.back();
            Get.back();
          }

          navigationController.navigatePageView(index);
        },
        child: Obx(() {
          return Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: Align(
              alignment: Alignment.center,
              child: FittedBox(
                child: SvgPicture.asset(
                  icon,
                  width: 25,
                  height: 25,
                  colorFilter: ColorFilter.mode(
                    navigationController.currentIndex == index
                        ? (isBackPage
                            ? AppColors.blueColor
                            : AppColors.whiteColor)
                        : AppColors.blueColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
