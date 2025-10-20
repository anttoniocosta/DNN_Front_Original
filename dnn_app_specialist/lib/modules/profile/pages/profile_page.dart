import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

import '../../base/pages/base_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(builder: (_) {
      return MobileLayout(
        needCenter: _.userAccount == null,
        needScrollView: true,
        appBarLeading: const MenuButtom(),
        title: 'Meu perfil',
        hasLeading: true,
        maxWidth: Responsive.maxWidth(),
        drawer: const DrawerCustom(navbarItems: NaviItems()),
        bodyChild: const ProfilePartialPage(),
      );
    });
  }
}
