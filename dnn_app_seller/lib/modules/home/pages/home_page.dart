import 'package:dnn_app_seller/modules/modules.dart';
import 'package:dnn_campaign/dnn_campaign.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final constraints = const BoxConstraints(maxWidth: 900);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(initState: (__) {
      Future.delayed(
        const Duration(milliseconds: 10),
        () => authenticationController.needChangeInstance(),
      );
    }, builder: (_) {
      return MobileLayout(
        needCenter: false,
        needScrollView: true,
        needBounce: false,
        needMaxWidth: false,
        needAppBar: false,
        needPadding: false,
        drawer: const DrawerCustom(navbarItems: NaviItems()),
        bodyChild: CustomUpgradeWidget(
          upgradeChild: GetBuilder<NavigationController>(
            builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const HomeHeaderWidget(),
                  ConstrainedBox(
                    constraints: constraints,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GetBuilder<NavigationController>(
                          builder: (__) {
                            return GetBuilder<AuthenticationController>(
                              builder: (_) {
                                return Visibility(
                                  visible:
                                      __.isLogged && _.currentInstance != null,
                                  child: const CurrentInstanceWidget()
                                      .paddingOnly(
                                          left: 20, right: 20, top: 20),
                                );
                              },
                            );
                          },
                        ),
                        20.heightGap,
                        Text(
                          'Minhas ações',
                          style: Fonts.titleMedium(context),
                        ).paddingSymmetric(horizontal: 20),
                        10.heightGap,
                        HomeActionsListWidget(cardList: clientCards),
                        80.heightGap
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }
}

final clientCards = [
  GetBuilder<NavigationController>(
    builder: (_) => CardTabsHome(
      isPrincipal: true,
      title: 'Links de venda',
      icon: FontAwesomeIcons.link,
      onTap: () async {
        if (!navigationController.isUserLogged.value) {
          navigationController.navigatePageView(NavigationTabs.login);
        } else {
          SellerLinkBinding().dependencies();
        }
      },
    ),
  ),
  HomeItemUtils.profileCard(
    profileAction: () =>
        navigationController.navigatePageView(NavigationTabs.login),
  ),
  HomeItemUtils.contactCard,
  HomeItemUtils.dashBoardCard,
  HomeItemUtils.ordersCard,
  HomeItemUtils.reportConfigCard,
];
