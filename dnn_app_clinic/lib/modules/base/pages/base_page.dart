import 'package:dnn_app_clinic/modules/modules.dart';
import 'package:dnn_authentication/dnn_authentication.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';

import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});
  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  static const loggedList = [
    HomePage(),
    AdSpecialistListPage(),
    AppointmentSpecialistListPage(),
    MySpecialistsListPage(),
    HelpersPage(),
  ];

  static const logoutedList = [
    HomePage(),
    HelpersPage(),
    SigninPage(),
  ];

  static List<Widget> loggedListItems = [
    const BottomItem(icon: FontAwesomeIcons.hospital, index: 0),
    10.widthGap,
    const BottomItem(
      icon: FontAwesomeIcons.solidAddressCard,
      index: 1,
    ),
    10.widthGap,
    const BottomItem(
      icon: FontAwesomeIcons.stethoscope,
      index: 2,
    ),
    10.widthGap,
    const BottomItem(
      icon: FontAwesomeIcons.userDoctor,
      index: 3,
    ),
    10.widthGap,
    const BottomItem(
      icon: FontAwesomeIcons.circleQuestion,
      index: 4,
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

  _clientBaseListPage() {
    if (navigationController.isLogged) return loggedList;
    return logoutedList;
  }

  _clientBaseListItems() {
    if (navigationController.isLogged) return loggedListItems;
    return logoutedListItems;
  }

  double _sizesClient() {
    if (navigationController.isLogged) return 250;
    return 175;
  }

  @override
  void initState() {
    accountController.needPhoneValidation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(builder: (_) {
      return BasePageWidget(
        navBarItems: const NavBarItems(),
        bottomNavigationItems: _clientBaseListItems(),
        bottomNavigationWidth: _sizesClient(),
        pageList: _clientBaseListPage(),
      );
    });
  }
}

class NavBarItems extends StatelessWidget {
  const NavBarItems({
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
              Column(
                children: [
                  MenuTileWidget(
                    title: 'Registrar',
                    icon: FontAwesomeIcons.doorOpen,
                    index: 1000,
                    onTap: () {
                      Get.toNamed(Routes.registerClinic);
                    },
                  ),
                  MenuTileWidget(
                    title: 'Entrar',
                    icon: FontAwesomeIcons.arrowRightToBracket,
                    index: 1000,
                    onTap: () {
                      if (Responsive.isTabletOrDesktop()) {
                        Scaffold.of(context).closeDrawer();
                      } else {
                        navigationController.closeMenu();
                      }
                      Get.toNamed(Routes.authPage);
                    },
                  ),
                ],
              ),
            ],
            if (navigationController.isUserLogged.value) ...[
              Column(
                children: [
                  const MenuTileWidget(
                    title: 'Minhas Anuncios',
                    icon: FontAwesomeIcons.solidAddressCard,
                    index: 1,
                  ),
                  const MenuTileWidget(
                    title: 'Meus Consultas',
                    icon: FontAwesomeIcons.stethoscope,
                    index: 2,
                  ),
                  const MenuTileWidget(
                    title: 'Meus Especialistas',
                    icon: FontAwesomeIcons.userDoctor,
                    index: 3,
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
                            navigationController.closeMenu();
                            await authenticationController.signOut(() async {
                              navigationController.setIsUserLogged(false);
                              await navigationController.getUserLogged();
                              Get.offAllNamed(Routes.basePage);
                            });
                          },
                        );
                      },
                    );
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
