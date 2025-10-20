import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class CustomBottomNavigation extends StatelessWidget {
  final bool? isOutSideHome;
  const CustomBottomNavigation({
    super.key,
    required this.navItens,
    this.isOutSideHome = true,
  });

  final List<Widget> navItens;

  _navigationBg() {
    return themeController.isDark.value
        ? AppColors.whiteColor.withOpacity(0.7)
        : AppColors.blueMarineColor;
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      if (isKeyboardVisible) return const SizedBox();
      return GetBuilder<NavigationController>(builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Obx(() {
            return Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 80),
              decoration: BoxDecoration(
                color: _navigationBg(),
                borderRadius: BorderRadius.circular(50),
                boxShadow: highElevation + highElevationTwo,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: navItens,
              ),
            ).marginSymmetric(vertical: 20, horizontal: 20);
          }),
        );
      });
    });
  }
}
