import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: SearchBar(
        controller: controller,
        padding:
            const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 23)),
        surfaceTintColor: const WidgetStatePropertyAll(AppColors.whiteColor),
        backgroundColor: Get.isDarkMode
            ? const WidgetStatePropertyAll(AppColors.blackDarkColor)
            : const WidgetStatePropertyAll(
                AppColors.defaultBackgroundCardColor),
        leading: SvgPicture.asset(MediaRes.search),
        shadowColor: WidgetStatePropertyAll(
          AppColors.blackLightColor.withOpacity(0.10),
        ),
        hintText: hintText,
        hintStyle: WidgetStatePropertyAll(
          Fonts.bodyLarge(context)
              .copyWith(fontSize: 14, color: AppColors.darkGreyColor),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
