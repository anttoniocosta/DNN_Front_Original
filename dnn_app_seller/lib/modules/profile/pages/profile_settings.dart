import 'package:dnn_app_seller/modules/modules.dart';
import 'package:dnn_authentication/modules/change_context/change_context_page.dart';
import 'package:dnn_dependencies/get_export.dart';
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
      bodyChild: ProfileSettingsPartial(settingList: [
        SettingsActions(
          title: 'Troca de contexto',
          icon: FontAwesomeIcons.typo3,
          onTap: () => Get.to(
            () => const ChangeContextPage(),
            transition: Responsive.isTabletOrDesktop()
                ? Transition.noTransition
                : Transition.cupertino,
          ),
        )
      ]),
    );
  }
}
