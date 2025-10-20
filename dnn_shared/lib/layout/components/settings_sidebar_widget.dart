import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_dependencies/sc_util.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class SettingSidebarWidget extends StatelessWidget {
  const SettingSidebarWidget({super.key, required this.navbarItems});

  final Widget navbarItems;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: themeController.isDark.value
            ? AppColors.blackDarkColor
            : AppColors.lighterGreyColor,
        body: SizedBox(
          width: 290.w,
          child: GetBuilder<NavigationController>(builder: (_) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const DrawerHeaderCustom().paddingSymmetric(vertical: 20),
                  navbarItems,
                ],
              ),
            );
          }),
        ).paddingSymmetric(horizontal: 10, vertical: 20),
      );
    });
  }
}
