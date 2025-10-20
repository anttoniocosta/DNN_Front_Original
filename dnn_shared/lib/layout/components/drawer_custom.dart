import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({super.key, required this.navbarItems});

  final Widget navbarItems;

  _drawerBackground() {
    return Get.isDarkMode ? AppColors.midBlackColor : AppColors.whiteColor;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: _drawerBackground(),
      surfaceTintColor: _drawerBackground(),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SingleChildScrollView(
        child: GetBuilder<NavigationController>(
          builder: (_) {
            return Column(
              children: [const DrawerHeaderCustom(), 20.heightGap, navbarItems],
            ).paddingSymmetric(horizontal: 10, vertical: 20);
          },
        ),
      ),
    );
  }
}
