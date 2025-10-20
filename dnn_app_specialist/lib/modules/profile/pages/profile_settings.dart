import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      maxWidth: Responsive.maxWidth(),
      title: pagesController.currentPage(PagesEnum.profileSettings)!.name,
      bodyChild: const ProfileSettingsPartial(settingList: []),
    );
  }
}
