import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class MenuButtom extends StatelessWidget {
  const MenuButtom({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(builder: (_) {
      return IconButton(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
          Scaffold.of(context).openDrawer();
          navigationController.updateDrawerBar(true);
        },
        icon: Icon(
          Icons.menu_rounded,
          color: color ?? AppColors.whiteColor,
          size: 34,
        ),
      );
    });
  }
}
