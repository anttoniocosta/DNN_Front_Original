import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileSettingsPartial extends StatelessWidget {
  const ProfileSettingsPartial({super.key, required this.settingList});

  final List<Widget> settingList;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(pgEnum: PagesEnum.profileSettings),
          16.heightGap,
          SettingsActions(
            title: 'Editar dados',
            icon: FontAwesomeIcons.userPen,
            onTap: () {
              navigationController.closeMenu();
              Get.toNamed(Routes.myEditData);
            },
          ),
          SettingsActions(
            title: 'Redefinir senha',
            icon: FontAwesomeIcons.lock,
            onTap: () {
              navigationController.closeMenu();
              Get.toNamed(Routes.myUpdatePassword);
            },
          ),
          ...settingList,
          Visibility(
            visible: !kReleaseMode,
            child: SettingsActions(
              title: 'Ambiente',
              icon: FontAwesomeIcons.building,
              onTap: () => Get.toNamed(Routes.environment),
            ),
          ),
          Obx(() {
            return SettingsActions(
              onTap: () => themeController.changeTheme(),
              icon: themeController.isDark.value
                  ? FontAwesomeIcons.solidSun
                  : FontAwesomeIcons.solidMoon,
              title:
                  themeController.isDark.value ? 'Tema claro' : 'Tema escuro',
            );
          }),
          // GetBuilder<QualityAssuranceController>(
          //   builder: (_) {
          //     if (_.hasQA) {
          //       return SettingsActions(
          //         title: 'Perfis de Teste | QA',
          //         icon: FontAwesomeIcons.userGear,
          //         onTap: () {
          //           _.getScenarios();
          //           navigationController.closeMenu();
          //           Get.toNamed(Routes.qaTest);
          //         },
          //       );
          //     }
          //     return const SizedBox();
          //   },
          // ),
          const VersionTextWidget()
        ],
      );
    });
  }
}
