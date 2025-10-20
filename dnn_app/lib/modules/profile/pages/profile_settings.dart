import 'package:dnn_app/modules/modules.dart';
import 'package:flutter/material.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      maxWidth: Responsive.maxWidth(),
      appBarLeading: const MenuButtom(),
      hasLeading: true,
      drawer: const DrawerCustom(navbarItems: NaviItems()),
      title: pagesController.currentPage(PagesEnum.profileSettings)!.name,
      bodyChild: const ProfileSettingsPartial(settingList: []),
    );
  }
}
