import 'package:dnn_app/modules/home/pages/home_page.dart';
import 'package:dnn_app/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  final bool? isActive;

  const BasePage({super.key, this.isActive});
  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  List<Widget>? pages = List<Widget>.generate(
      3, (_) => Scaffold(body: Container(color: Colors.transparent)));

  static const logoutedListPage = [
    HomePage(),
    HelpersPage(showAppBar: false),
    SigninPage(showAppBar: false),
  ];

  static const loggedListPage = [
    MyAppointmentsPage(showAppBar: false),
    HomePage(),
    MyPlansPage(showAppBar: false),
  ];

  static List<Widget> loggedListItems = [
    const CustomBottomItem(
      icon: MediaRes.stetoscpIcon,
      index: NavigationTabs.myAppointmentsLogged,
    ),
    10.widthGap,
    const CustomBottomItem(
      icon: MediaRes.homeIcon,
      index: NavigationTabs.homeLogged,
    ),
    10.widthGap,
    const CustomBottomItem(
      icon: MediaRes.malletIcon,
      index: NavigationTabs.myPlansLogged,
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
    final arguments = Get.arguments as Map<String, dynamic>?;
    final bool? isActiveValue = arguments?['isActive'];

    if (isActiveValue ?? true) {
      accountController.needPhoneValidation();
    }

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
          pageList: _clientBaseListPage());
    });
  }
}

class NaviItems extends StatefulWidget {
  const NaviItems({super.key});

  @override
  State<NaviItems> createState() => _NaviItemsState();
}

class _NaviItemsState extends State<NaviItems> {
  bool isMyPlansClicked = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      builder: (_) {
        return Column(
          children: [
            if (!navigationController.isUserLogged.value)
              SizedBox(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        Scaffold.of(context).closeDrawer();
                        Get.toNamed(Routes.registerPersonal);
                      },
                      child: const Text("Registrar"),
                    ),
                    TextButton(
                      onPressed: () {
                        Scaffold.of(context).closeDrawer();
                        navigationController
                            .navigatePageView(NavigationTabs.login);
                      },
                      child: const Text("Entrar"),
                    ),
                  ],
                ),
              ),
            if (navigationController.isUserLogged.value)
              SizedBox(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        Scaffold.of(context).closeDrawer();
                        Get.toNamed(Routes.profile);
                      },
                      child: Text(
                        "Meu perfil",
                        style: Fonts.bodyLarge(context).copyWith(
                          fontFamily: Fonts.poppins,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Scaffold.of(context).closeDrawer();
                        _.navigatePageView(NavigationTabs.meusPlanos);
                      },
                      child: Text(
                        "Meus planos",
                        style: Fonts.bodyLarge(context).copyWith(
                          fontFamily: Fonts.poppins,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Scaffold.of(context).closeDrawer();
                        Get.toNamed(Routes.profileSettings);
                      },
                      child: Text(
                        "Configurações",
                        style: Fonts.bodyLarge(context).copyWith(
                          fontFamily: Fonts.poppins,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        Get.toNamed(
                          Routes.useTerms,
                          arguments: true,
                        );
                      },
                      child: Text(
                        "Termos e Politicas",
                        style: Fonts.bodyLarge(context).copyWith(
                          fontFamily: Fonts.poppins,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        CustomDialogs.confirmDialog(
                          title: 'Deseja realmente sair?',
                          context: context,
                          backVisible: true,
                          backAcion: () {
                            Scaffold.of(context).closeDrawer();
                          },
                          confirmAcion: () async {
                            Scaffold.of(context).closeDrawer();
                            ShoppingCartBinding().dependencies();
                            await shoppingCartController
                                .getShoppingCartSecondCall();
                            shoppingCartController.deleteShoppingCart();
                            authenticationController.signOut(() {
                              navigationController.getUserLogged();
                              Get.offAllNamed(Routes.basePage);
                            });
                          },
                        );
                      },
                      child: Text(
                        "Sair",
                        style: Fonts.titleLarge(context).copyWith(
                          color: AppColors.redColor,
                          fontFamily: Fonts.poppins,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
