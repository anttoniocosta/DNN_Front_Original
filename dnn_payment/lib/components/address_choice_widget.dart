import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class AddressChoiceWidget extends StatelessWidget {
  const AddressChoiceWidget({
    super.key,
    required this.onTap,
    required this.child,
  });

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color:
              Get.isDarkMode ? AppColors.midBlackColor : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: highElevation,
        ),
        width: double.infinity,
        child: child,
      ),
    );
  }
}
