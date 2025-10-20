import 'package:dnn_app_clinic/core/core.dart';
import 'package:dnn_app_clinic/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_offers/dnn_offers.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OffersController>(
      builder: (_) {
        return MobileLayout(
          needCenter: false,
          needScrollView: true,
          needBounce: false,
          needMaxWidth: false,
          needAppBar: false,
          needPadding: false,
          onRefresh: () async => _.getOffers(),
          drawer: const DrawerCustom(navbarItems: NavBarItems()),
          bodyChild: CustomUpgradeWidget(
            upgradeChild: GetBuilder<NavigationController>(
              builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const HomeHeaderWidget(),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          16.heightGap,
                          // Text(
                          //   'Visão geral da sua clínica',
                          //   style: Fonts.titleLarge(context),
                          //   textAlign: TextAlign.center,
                          // ).paddingSymmetric(horizontal: 20),
                          // 16.heightGap,
                          // const ConsultsScheduled(quantity: 10)
                          //     .paddingOnly(right: 10),
                          // 20.heightGap,
                          Text(
                            'Minhas ações',
                            style: Fonts.titleMedium(context),
                          ).paddingSymmetric(horizontal: 20),
                          10.heightGap,
                          HomeActionsListWidget(cardList: clientCards),
                          80.heightGap
                        ],
                      ),
                    )
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
    builder: (_) {
      return GetBuilder<PublishAgendaController>(builder: (pbAgenda) {
        return CardTabsHome(
          title: 'Divulgar\nAgenda',
          isPrincipal: true,
          icon: FontAwesomeIcons.solidShareFromSquare,
          onTap: () {
            if (!_.isLogged) {
              _.navigatePageView(NavigationTabs.login);
            } else {
              pbAgenda.setIsReadyService(false);
              Get.toNamed(Routes.publishSpecialist);
            }
          },
        );
      });
    },
  ),
  GetBuilder<NavigationController>(
    builder: (_) {
      return GetBuilder<PublishAgendaController>(builder: (pbAgenda) {
        return CardTabsHome(
          title: 'Divulgar Pronto Atendimento',
          isPrincipal: true,
          icon: FontAwesomeIcons.solidShareFromSquare,
          onTap: () {
            if (!_.isLogged) {
              _.navigatePageView(NavigationTabs.login);
            } else {
              pbAgenda.setIsReadyService(true);
              Get.toNamed(Routes.publishSpecialist);
            }
          },
        );
      });
    },
  ),
  GetBuilder<NavigationController>(
    builder: (_) {
      return CardTabsHome(
        title: 'Minhas Agendas',
        icon: FontAwesomeIcons.solidAddressCard,
        onTap: () {
          if (!_.isLogged) {
            _.navigatePageView(NavigationTabs.login);
          } else {
            Get.toNamed(Routes.adSelectSpecialist);
          }
        },
      );
    },
  ),
  GetBuilder<NavigationController>(
    builder: (_) {
      return CardTabsHome(
        title: 'Minhas Consultas',
        icon: FontAwesomeIcons.stethoscope,
        onTap: () {
          if (!_.isLogged) {
            _.navigatePageView(NavigationTabs.login);
          } else {
            Get.toNamed(Routes.appointmentSpecialistList);
          }
        },
      );
    },
  ),
  GetBuilder<NavigationController>(
    builder: (_) {
      return CardTabsHome(
        title: 'Meus Especialistas',
        icon: FontAwesomeIcons.userDoctor,
        onTap: () {
          if (!_.isLogged) {
            _.navigatePageView(NavigationTabs.login);
          } else {
            Get.toNamed(Routes.mySpecialistList);
          }
        },
      );
    },
  ),
  // GetBuilder<NavigationController>(
  //   builder: (_) {
  //     return CardTabsHome(
  //       title: 'Dados da Clínica',
  //       icon: FontAwesomeIcons.receipt,
  //       onTap: () {
  //         if (!_.isLogged) {
  //           _.navigatePageView(NavigationTabs.login);
  //         } else {
  //           Get.toNamed(Routes.clinicaData);
  //         }
  //       },
  //     );
  //   },
  // ),
  HomeItemUtils.contactCard,
];
