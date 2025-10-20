import 'package:dnn_app/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

class MyPlansPage extends StatefulWidget {
  final bool showAppBar;
  const MyPlansPage({super.key, this.showAppBar = true});

  @override
  State<MyPlansPage> createState() => _MyPlansPageState();
}

class _MyPlansPageState extends State<MyPlansPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoicesController>(
      builder: (_) {
        return MobileLayout(
          needCenter: false,
          needScrollView: true,
          needAppBar: widget.showAppBar,
          title: pagesController.currentPage(PagesEnum.myPlans)?.name,
          hasLeading: true,
          appBarLeading: const MenuButtom(),
          onRefresh: () => _.getInvoices(force: true),
          drawer: const DrawerCustom(navbarItems: NaviItems()),
          maxWidth: Responsive.maxWidth(),
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
                        index: currentIndex, type: 'plan'),
                    crossFadeState: _.getInvoicesLoading.value
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 50),
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
