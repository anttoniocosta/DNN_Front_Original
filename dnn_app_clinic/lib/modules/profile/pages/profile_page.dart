import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget? _leading() {
    if (Get.currentRoute == Routes.basePage) return const MenuButtom();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(builder: (_) {
      return MobileLayout(
        needCenter: _.userAccount == null,
        needScrollView: true,
        appBarLeading: _leading(),
        title: 'Meu perfil',
        hasLeading: true,
        maxWidth: Responsive.maxWidth(),
        bodyChild: const ProfilePartialPage(),
      );
    });
  }
}
