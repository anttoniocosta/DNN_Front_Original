import 'package:dnn_app_company/components/portal_web_view.dart';
import 'package:dnn_app_company/modules/modules.dart';
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
    MyPlansPage(),
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
      icon: FontAwesomeIcons.bookMedical,
      index: NavigationTabs.meusPlanos,
    ),
    10.widthGap,
    const BottomItem(
      icon: FontAwesomeIcons.circleUser,
      index: NavigationTabs.profile,
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

  double _sizesClient() {
    if (navigationController.isLogged) return 200;
    return 175;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(builder: (_) {
      return BasePageWidget(
        navBarItems: const NaviItems(),
        bottomNavigationItems: _clientBaseListItems(),
        bottomNavigationWidth: _sizesClient(),
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
                      Get.toNamed(Routes.registerCompany);
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
                            'urlPage': '/hic/dashboard/index',
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
                            'urlPage': '/hic/orders/index',
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
                            'urlPage': '/hic/reportconfig/preview',
                            'title': 'Relatórios'
                          },
                          transition: Transition.cupertino);
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
                            Navigator.of(context).pop();
                            ShoppingCartBinding().dependencies();
                            await shoppingCartController
                                .getShoppingCartSecondCall();
                            shoppingCartController.deleteShoppingCart();
                            navigationController.closeMenu();
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
