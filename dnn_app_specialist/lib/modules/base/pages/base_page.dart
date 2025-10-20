import 'package:dnn_app_specialist/core/specialist/controller/speacialist_controller.dart';
import 'package:dnn_app_specialist/modules/home/pages/home_page.dart';
import 'package:dnn_app_specialist/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});
  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  static const logoutedListPage = [
    HomePage(),
    HelpersPage(),
    SigninPage(),
  ];

  static const loggedListPage = [
    HomePage(),
    HelpersPage(),
    ProfilePage(),
  ];

  static List<Widget> loggedListItems = [
    const BottomItem(
      icon: FontAwesomeIcons.hospital,
      index: NavigationTabs.home,
    ),
    10.widthGap,
    const BottomItem(
      icon: FontAwesomeIcons.circleQuestion,
      index: NavigationTabs.helpers,
    ),
    10.widthGap,
    const BottomItem(
      icon: FontAwesomeIcons.circleUser,
      index: NavigationTabs.login,
    ),
  ];

  static List<Widget> logoutedListItems = [
    const BottomItem(
      icon: FontAwesomeIcons.hospital,
      index: NavigationTabs.home,
    ),
    10.widthGap,
    const BottomItem(
      icon: FontAwesomeIcons.circleQuestion,
      index: NavigationTabs.helpers,
    ),
    10.widthGap,
    const BottomItem(
      icon: FontAwesomeIcons.arrowRightToBracket,
      index: NavigationTabs.login,
    ),
  ];

  @override
  void initState() {
    accountController.needPhoneValidation();
    super.initState();
  }

  _clientBaseListPage() {
    if (navigationController.isUserLogged.value) return loggedListPage;
    return logoutedListPage;
  }

  _clientBaseListItems() {
    if (navigationController.isUserLogged.value) return loggedListItems;
    return logoutedListItems;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(builder: (_) {
      return BasePageWidget(
        navBarItems: const NaviItems(),
        bottomNavigationItems: _clientBaseListItems(),
        bottomNavigationWidth: 175,
        pageList: _clientBaseListPage(),
      );
    });
  }
}

class NaviItems extends StatelessWidget {
  const NaviItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      builder: (_) {
        return Column(
          children: [
            const MenuTileWidget(
              title: 'Início',
              icon: FontAwesomeIcons.hospital,
              index: NavigationTabs.home,
            ),
            if (!navigationController.isUserLogged.value) ...[
              const MenuTileWidget(
                title: 'Entrar',
                icon: FontAwesomeIcons.arrowRightToBracket,
                index: NavigationTabs.login,
              ),
            ],
            if (navigationController.isUserLogged.value) ...[
              Column(
                children: [
                  MenuTileWidget(
                    title: 'Minhas Consultas',
                    icon: FontAwesomeIcons.stethoscope,
                    index: 1000,
                    onTap: () {
                      if (Responsive.isTabletOrDesktop()) {
                        Scaffold.of(context).closeDrawer();
                      } else {
                        navigationController.closeMenu();
                      }
                      Get.toNamed(Routes.appointmentedSelectDay);
                    },
                  ),
                  const MenuTileWidget(
                    title: 'Meu perfil',
                    icon: FontAwesomeIcons.circleUser,
                    index: NavigationTabs.profile,
                  ),
                  MenuTileWidget(
                    title: 'Configurações',
                    icon: FontAwesomeIcons.gear,
                    index: 1000,
                    onTap: () {
                      if (Responsive.isTabletOrDesktop()) {
                        Scaffold.of(context).closeDrawer();
                      } else {
                        navigationController.closeMenu();
                      }
                      Get.toNamed(Routes.profileSettings);
                    },
                  ),
                  GetBuilder<AuthenticationController>(builder: (_) {
                    return GetBuilder<SpecialistController>(
                        builder: (specialist) {
                      return MenuTileWidget(
                        title: 'Sair',
                        icon: FontAwesomeIcons.arrowRightFromBracket,
                        index: 1000,
                        onTap: () {
                          CustomDialogs.confirmDialog(
                            title: 'Deseja realmente sair?',
                            context: context,
                            backVisible: true,
                            backAcion: () {
                              Navigator.of(context).pop();
                            },
                            confirmAcion: () async {
                              Navigator.of(context).pop();
                              specialist.finishDuty();
                              navigationController.closeMenu();
                              authenticationController.signOut(() {
                                navigationController.getUserLogged();
                                Get.offAllNamed(Routes.basePage);
                              });
                            },
                          );
                        },
                      );
                    });
                  })
                ],
              ),
            ]
          ],
        );
      },
    );
  }
}
