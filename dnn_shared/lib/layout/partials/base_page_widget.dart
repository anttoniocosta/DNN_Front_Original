import 'package:dnn_app/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

class BasePageWidget extends StatelessWidget {
  const BasePageWidget({
    super.key,
    required this.navBarItems,
    required this.bottomNavigationItems,
    required this.bottomNavigationWidth,
    required this.pageList,
  });

  final Widget navBarItems;
  final List<Widget> bottomNavigationItems;
  final double bottomNavigationWidth;
  final List<Widget> pageList;

  @override
  Widget build(BuildContext context) {
    if (Responsive.isTabletOrDesktop()) {
      return _BasePageWeb(
        navBarItems: navBarItems,
        bottomNavigationItems: bottomNavigationItems,
        bottomNavigationWidth: bottomNavigationWidth,
        pageList: pageList,
      );
    } else {
      return _BasePageMobile(
        navBarItems: navBarItems,
        bottomNavigationItems: bottomNavigationItems,
        bottomNavigationWidth: bottomNavigationWidth,
        pageList: pageList,
      );
    }
  }
}

class _BasePageMobile extends StatelessWidget {
  const _BasePageMobile({
    required this.navBarItems,
    required this.bottomNavigationItems,
    required this.bottomNavigationWidth,
    required this.pageList,
  });

  final Widget navBarItems;
  final List<Widget> bottomNavigationItems;
  final double bottomNavigationWidth;
  final List<Widget> pageList;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      builder: (_) {
        return Scaffold(
          drawer: const DrawerCustom(navbarItems: NaviItems()),
          body: Stack(
            children: [
              PageView(
                controller: navigationController.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: pageList,
              ).paddingOnly(top: 140),
              const Align(
                alignment: Alignment.topCenter,
                child: HomeHeaderWidget(),
              ),
            ],
          ),
          bottomSheet: CustomBottomNavigation(
            navItens: bottomNavigationItems,
          ),
        );
      },
    );
  }
}

class _BasePageWeb extends StatelessWidget {
  const _BasePageWeb({
    required this.navBarItems,
    required this.bottomNavigationItems,
    required this.bottomNavigationWidth,
    required this.pageList,
  });

  final Widget navBarItems;
  final List<Widget> bottomNavigationItems;
  final double bottomNavigationWidth;
  final List<Widget> pageList;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      builder: (_) {
        return Scaffold(
          drawer: DrawerCustom(navbarItems: navBarItems),
          body: PageView(
            controller: navigationController.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: pageList,
          ),
        );
      },
    );
  }
}
