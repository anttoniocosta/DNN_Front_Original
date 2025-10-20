import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class BilletActions extends StatelessWidget {
  const BilletActions({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
  });

  final VoidCallback onTap;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color:
              Get.isDarkMode ? AppColors.midBlackColor : AppColors.whiteColor,
          boxShadow: highElevation,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Fonts.bodyLarge(context),
              textAlign: TextAlign.center,
            ),
            IconButton(
              onPressed: null,
              icon: FaIcon(icon, size: 24, color: AppColors.blueColor),
            )
          ],
        ),
      ),
    );
  }
}
