import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({
    super.key,
    required this.onTap,
    required this.child,
    this.radius,
    this.horizontalPadding,
    this.bgColor,
    this.fgColor,
  });

  final VoidCallback? onTap;
  final Widget child;
  final double? radius;
  final double? horizontalPadding;
  final Color? bgColor;
  final Color? fgColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius ?? 50),
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 8, horizontal: horizontalPadding ?? 24),
        decoration: BoxDecoration(
          color: bgColor ?? Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(radius ?? 50),
          boxShadow: highElevation,
        ),
        child: child,
      ).paddingOnly(bottom: 10),
    );
  }
}

class SearchTileSelection extends StatelessWidget {
  const SearchTileSelection({
    super.key,
    required this.onTap,
    this.isSelected = false,
    required this.title,
  });
  final VoidCallback onTap;
  final bool? isSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SearchResultTile(
      bgColor: isSelected!
          ? Get.isDarkMode
              ? AppColors.lighterblackLightColor
              : AppColors.blackDarkColor
          : null,
      onTap: onTap,
      child: Text(
        title,
        style: isSelected!
            ? Fonts.titleSmall(context).copyWith(color: AppColors.whiteColor)
            : Fonts.bodyLarge(context),
      ),
    );
  }
}

class HourCardSelection extends StatelessWidget {
  const HourCardSelection({
    super.key,
    required this.onTap,
    this.isSelected = false,
    required this.title,
  });
  final VoidCallback onTap;
  final bool? isSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SearchResultTile(
      radius: 20,
      bgColor: isSelected!
          ? Get.isDarkMode
              ? AppColors.lighterblackLightColor
              : AppColors.blackDarkColor
          : null,
      onTap: onTap,
      child: Text(
        title,
        style: isSelected!
            ? Fonts.titleSmall(context).copyWith(color: AppColors.whiteColor)
            : Fonts.titleSmall(context),
      ).toCenter.paddingSymmetric(vertical: 10),
    );
  }
}
