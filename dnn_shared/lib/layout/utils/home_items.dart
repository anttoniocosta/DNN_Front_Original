import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

abstract class HomeItemUtils {
  static Widget get contactCard {
    return CardTabsHome(
      title: 'Contato',
      imageSrc: MediaRes.contatos,
      onTap: () async => CustomDialogs.contactWithUsDialog(),
    );
  }

  static Widget contactCardClient({required Widget content}) {
    return CardTabsHome(
      title: 'Contato',
      imageSrc: MediaRes.contatos,
      onTap: () async => CustomDialogs.modalBottomSheet(
        context: Get.context!,
        content: content,
      ),
    );
  }

  static Widget campaignCard({
    required String title,
    bool isPrincipal = false,
  }) {
    return GetBuilder<NavigationController>(
      builder: (_) => CardTabsHome(
        isPrincipal: isPrincipal,
        title: title,
        imageSrc: MediaRes.assinarPlanos,
        onTap: () async {
          await storage.setPaymentCicle(1);
          Get.toNamed(Routes.campaignMainOffers);
        },
      ),
    );
  }

  static Widget get dashBoardCard {
    return GetBuilder<NavigationController>(
      builder: (_) => CardTabsHome(
        title: 'Dashboard',
        icon: FontAwesomeIcons.gauge,
        onTap: () async {
          if (!_.isLogged) {
            _.navigatePageView(NavigationTabs.login);
          } else {
            Get.toNamed(
              Routes.portalWebView,
              arguments: {
                'urlPage': '/${appContext.ctx}/dashboard/index',
                'title': 'Dashboard'
              },
            );
          }
        },
      ),
    );
  }

  static Widget get ordersCard {
    return GetBuilder<NavigationController>(
      builder: (_) => CardTabsHome(
        title: 'Meus Pedidos',
        icon: FontAwesomeIcons.bookOpenReader,
        onTap: () async {
          if (!_.isLogged) {
            _.navigatePageView(NavigationTabs.login);
          } else {
            Get.toNamed(
              Routes.portalWebView,
              arguments: {
                'urlPage': '/${appContext.ctx}/orders/index',
                'title': 'Meus pedidos'
              },
            );
          }
        },
      ),
    );
  }

  static Widget get reportConfigCard {
    return GetBuilder<NavigationController>(
      builder: (_) => CardTabsHome(
        title: 'Relatórios',
        icon: FontAwesomeIcons.fileContract,
        onTap: () async {
          if (!_.isLogged) {
            _.navigatePageView(NavigationTabs.login);
          } else {
            Get.toNamed(
              Routes.portalWebView,
              arguments: {
                'urlPage': '/${appContext.ctx}/reportconfig/preview',
                'title': 'Relatórios'
              },
            );
          }
        },
      ),
    );
  }

  static Widget profileCard({void Function()? profileAction}) {
    return GetBuilder<NavigationController>(
      builder: (_) => CardTabsHome(
        title: 'Meus Dados',
        icon: FontAwesomeIcons.solidUser,
        onTap: () async {
          if (!navigationController.isUserLogged.value) {
            navigationController.navigatePageView(NavigationTabs.login);
          } else {
            profileAction ??
                navigationController.navigatePageView(NavigationTabs.profile);
          }
        },
      ),
    );
  }

  static Widget get myInvoices {
    return GetBuilder<NavigationController>(
      builder: (_) => CardTabsHome(
        title: 'Faturas',
        icon: FontAwesomeIcons.fileInvoiceDollar,
        onTap: () async {
          if (!_.isLogged) {
            _.navigatePageView(NavigationTabs.login);
          } else {
            Get.toNamed(Routes.myInvoices);
          }
        },
      ),
    );
  }

  static Widget get myPlans {
    return GetBuilder<NavigationController>(
      builder: (_) => CardTabsHome(
        title: 'Meus Planos',
        icon: FontAwesomeIcons.bookMedical,
        onTap: () async {
          if (!_.isLogged) {
            _.navigatePageView(NavigationTabs.login);
          } else {
            _.navigatePageView(NavigationTabs.meusPlanos);
          }
        },
      ),
    );
  }
}
