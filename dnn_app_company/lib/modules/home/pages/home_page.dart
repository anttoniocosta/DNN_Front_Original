import 'package:dnn_app_company/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final constraints = const BoxConstraints(maxWidth: 900);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
      initState: (__) {
        Future.delayed(
          const Duration(milliseconds: 10),
          () => authenticationController.needChangeInstance(),
        );
      },
      builder: (authCtrl) {
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
                          if (_.isLogged && authCtrl.currentInstance != null)
                            const CurrentInstanceWidget()
                                .paddingOnly(left: 20, right: 20, top: 20),
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
      },
    );
  }
}

final clientCards = [
  GetBuilder<NavigationController>(
    builder: (_) => CardTabsHome(
      isPrincipal: true,
      title: 'Adicionar Associado',
      icon: FontAwesomeIcons.kitMedical,
      onTap: () {
        if (!_.isLogged) {
          _.navigatePageView(NavigationTabs.login);
        } else {
          Get.toNamed(Routes.campaignHireForDependent);
        }
      },
    ),
  ),
  HomeItemUtils.myPlans,
  HomeItemUtils.profileCard(),
  HomeItemUtils.myInvoices,
  HomeItemUtils.dashBoardCard,
  HomeItemUtils.ordersCard,
  HomeItemUtils.reportConfigCard,
];
