import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';
import '../../dnn_shared.dart';

class MenuTileWidget extends StatelessWidget {
  const MenuTileWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.index,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final int index;
  final VoidCallback? onTap;

  _tileColor() =>
      navigationController.currentIndex == index ? AppColors.blueColor : null;

  _currentColor() =>
      (navigationController.currentIndex == index || Get.isDarkMode)
          ? AppColors.whiteColor
          : null;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      builder: (_) {
        return InkWell(
          onTap: onTap ??
              () {
                navigationController.navigatePageView(index);
                navigationController.closeMenu();
              },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            width: Get.mediaQuery.size.width,
            decoration: BoxDecoration(
              color: _tileColor(),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  child: FaIcon(
                    icon,
                    size: 26,
                    color: _currentColor(),
                  ).toCenter,
                ),
                10.widthGap,
                Text(
                  title,
                  style: Fonts.titleMedium(context).copyWith(
                    color: _currentColor(),
                  ),
                )
              ],
            ),
          ),
        ).paddingSymmetric(vertical: 6);
      },
    );
  }
}
