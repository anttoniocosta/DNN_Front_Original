import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:dnn_dependencies/get_export.dart';

class CardIconWidget extends StatelessWidget {
  const CardIconWidget({
    super.key,
    this.cardColor,
    required this.radius,
    required this.icon,
    this.iconColor,
    this.iconSize,
  });

  final Color? cardColor;
  final Color? iconColor;
  final double radius;
  final IconData icon;
  final double? iconSize;

  Color _cardColorBasic() {
    return Get.isDarkMode
        ? AppColors.lighterblackLightColor
        : AppColors.blueColor;
  }

  Color _iconColor() {
    return Get.isDarkMode ? AppColors.blueColor : AppColors.whiteColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(radius),
      decoration: BoxDecoration(
        color: cardColor ?? _cardColorBasic(),
        shape: BoxShape.circle,
        boxShadow: highElevation,
      ),
      child: FittedBox(
          child: FaIcon(
        icon,
        color: iconColor ?? _iconColor(),
        size: iconSize ?? 24,
      ).paddingAll(4)),
    );
  }
}
