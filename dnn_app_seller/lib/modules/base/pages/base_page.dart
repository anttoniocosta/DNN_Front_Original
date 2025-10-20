import 'package:dnn_app_seller/components/portal_web_view.dart';
import 'package:dnn_app_seller/modules/modules.dart';
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
    if (navigationController.isLogged) return loggedListPage;
    return logoutedListPage;
  }

  _clientBaseListItems() {
    if (navigationController.isLogged) return loggedListItems;
    return logoutedListItems;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(builder: (_) {
      return BasePageWidget(
        navBarItems: const NaviItems(),
        bottomNavigationItems: _clientBaseListItems(),
        bottomNavigationWidth: 165,
        pageList: _clientBaseListPage(),
      );
    });
  }
}

class NaviItems extends StatelessWidget {
  const NaviItems({super.key});

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
                      Get.toNamed(Routes.registerType);
                    },
                  ),
                  const MenuTileWidget(
                    title: 'Entrar',
                    icon: FontAwesomeIcons.arrowRightToBracket,
                    index: NavigationTabs.login,
                  ),
                ],
              ),
            ],
            if (navigationController.isUserLogged.value) ...[
              Column(
                children: [
                  MenuTileWidget(
                    title: 'Dashboard',
                    icon: FontAwesomeIcons.gauge,
                    index: 1000,
                    onTap: () {
                      if (Responsive.isTabletOrDesktop()) {
                        Scaffold.of(context).closeDrawer();
                      } else {
                        navigationController.closeMenu();
                      }
                      Get.to(() => const PortalWebView(),
                          arguments: {
                            'urlPage': '/${appContext.ctx}/dashboard/index',
                            'title': 'Dashboard'
                          },
                          transition: Transition.cupertino);
                    },
                  ),
                  MenuTileWidget(
                    title: 'Meus Pedidos',
                    icon: FontAwesomeIcons.bookOpenReader,
                    index: 1000,
                    onTap: () {
                      if (Responsive.isTabletOrDesktop()) {
                        Scaffold.of(context).closeDrawer();
                      } else {
                        navigationController.closeMenu();
                      }
                      Get.to(() => const PortalWebView(),
                          arguments: {
                            'urlPage': '/${appContext.ctx}/orders/index',
                            'title': 'Meus pedidos'
                          },
                          transition: Transition.cupertino);
                    },
                  ),
                  MenuTileWidget(
                    title: 'Relatórios',
                    icon: FontAwesomeIcons.fileContract,
                    index: 1000,
                    onTap: () {
                      if (Responsive.isTabletOrDesktop()) {
                        Scaffold.of(context).closeDrawer();
                      } else {
                        navigationController.closeMenu();
                      }
                      Get.to(() => const PortalWebView(),
                          arguments: {
                            'urlPage':
                                '/${appContext.ctx}/reportconfig/preview',
                            'title': 'Relatórios'
                          },
                          transition: Transition.cupertino);
                    },
                  ),
                  const MenuTileWidget(
                    title: 'Meu perfil',
                    icon: FontAwesomeIcons.circleUser,
                    index: NavigationTabs.login,
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
                            authenticationController.impersonateCode = '';
                            appContext.setCtx(null);
                            Navigator.of(context).pop();
                            navigationController.setIndex(NavigationTabs.home);
                            if (!Responsive.isTabletOrDesktop()) {
                              navigationController.closeMenu();
                            }
                            authenticationController.signOut(() {
                              navigationController.getUserLogged();
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
