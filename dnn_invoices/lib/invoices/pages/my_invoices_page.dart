import 'package:dnn_app/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

class MyContractsPage extends StatefulWidget {
  const MyContractsPage({super.key});

  @override
  State<MyContractsPage> createState() => _MyContractsPageState();
}

class _MyContractsPageState extends State<MyContractsPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoicesController>(
      builder: (_) {
        return MobileLayout(
          needCenter: false,
          needScrollView: true,
          appBar: const AppBarWithDrawer(),
          drawer: const DrawerCustom(navbarItems: NaviItems()),
          onRefresh: () => _.getInvoices(force: true),
          maxWidth: Responsive.maxWidth(),
          bottomSheet: CustomBottomNavigation(
            navItens: [
              const CustomBottomItem(
                isBackPage: true,
                icon: MediaRes.stetoscpIcon,
                index: NavigationTabs.myAppointmentsLogged,
              ),
              10.heightGap,
              const CustomBottomItem(
                isBackPage: true,
                icon: MediaRes.homeIcon,
                index: NavigationTabs.homeLogged,
              ),
              10.heightGap,
              const CustomBottomItem(
                isBackPage: true,
                icon: MediaRes.malletIcon,
                index: NavigationTabs.myPlansLogged,
              ),
            ],
          ),
          bodyChild: GetBuilder<InvoicesController>(
            builder: (_) {
              return Column(
                children: [
                  24.heightGap,
                  InvoiceFilterList(
                    currentIndex: currentIndex,
                    changeIndex: (e) => setState(() => currentIndex = e),
                  ),
                  32.heightGap,
                  AnimatedCrossFade(
                    firstChild: Column(
                      children: List.generate(
                          3,
                          (index) => const LoaderShimmerWidget()
                              .paddingOnly(bottom: 10)),
                    ),
                    secondChild: BodyContractListWidget(
                        index: currentIndex, type: 'invoice'),
                    crossFadeState: _.getInvoicesLoading.value
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 100),
                  ),
                  80.heightGap,
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class ActiveContractsPartial extends StatelessWidget {
  const ActiveContractsPartial({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    String title;
    String imageAsset;

    switch (type) {
      case 'plan':
        title = 'Sem planos ativos \nno momento';
        imageAsset = MediaRes.noPlans;

        break;
      case 'invoice':
        title = 'Sem faturas ativas \nno momento';
        imageAsset = MediaRes.noInvoices;
        break;

      default:
        title = 'Sem ativos \nno momento';
        imageAsset = MediaRes.noInvoices;
        break;
    }

    return GetBuilder<InvoicesController>(builder: (_) {
      final list = _.contractList.where(
        (contract) =>
            contract.cancelationAt == null && contract.blockedAt == null,
      );
      return SingleChildScrollView(
        controller: ScrollController(),
        child: list.isEmpty
            ? NoContractInformation(
                title: title,
                imageAsset: imageAsset,
              )
            : Column(
                children: list.map((e) => InvoiceCard(invoice: e)).toList(),
              ),
      );
    });
  }
}

class InactiveContractsPartial extends StatelessWidget {
  const InactiveContractsPartial({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    String title;
    String imageAsset;

    switch (type) {
      case 'plan':
        title = 'Sem planos inativos \nno momento';
        imageAsset = MediaRes.noPlans;

        break;
      case 'invoice':
        title = 'Sem faturas inativas \nno momento';
        imageAsset = MediaRes.noInvoices;
        break;

      default:
        title = 'Sem inativos \nno momento';
        imageAsset = MediaRes.noInvoices;
        break;
    }

    return GetBuilder<InvoicesController>(builder: (_) {
      final list = _.contractList.where((contract) =>
          contract.cancelationAt == null && contract.blockedAt != null);

      return SingleChildScrollView(
        controller: ScrollController(),
        child: list.isEmpty
            ? NoContractInformation(
                title: title,
                imageAsset: imageAsset,
              )
            : Column(
                children: list.map((e) => InvoiceCard(invoice: e)).toList(),
              ),
      );
    });
  }
}

class TerminatedContractsPartial extends StatelessWidget {
  const TerminatedContractsPartial({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    String title;
    String imageAsset;

    switch (type) {
      case 'plan':
        title = 'Sem planos encerrados \nno momento';
        imageAsset = MediaRes.noPlans;

        break;
      case 'invoice':
        title = 'Sem faturas encerradas \nno momento';
        imageAsset = MediaRes.noInvoices;
        break;

      default:
        title = 'Sem encerrados \nno momento';
        imageAsset = MediaRes.noInvoices;
        break;
    }

    return GetBuilder<InvoicesController>(builder: (_) {
      final list =
          _.contractList.where((contract) => contract.cancelationAt != null);

      return SingleChildScrollView(
        controller: ScrollController(),
        child: list.isEmpty
            ? NoContractInformation(
                title: title,
                imageAsset: imageAsset,
              )
            : Column(
                children: list
                    .map(
                        (e) => InvoiceCard(invoice: e, seeInvoiceButtom: false))
                    .toList(),
              ),
      );
    });
  }
}
