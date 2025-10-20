import 'package:dnn_campaign/dnn_campaign.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class CampaignCartConfirmPage extends StatelessWidget {
  const CampaignCartConfirmPage({super.key});

  bool isLoadingOrEmpty() {
    return (shoppingCartController.shoppingCartItemsLoading.value ||
        shoppingCartController.shoppingCartComplete == null);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShoppingCartController>(
      builder: (_) {
        return MobileLayout(
          needCenter: _.shoppingCartItemsLoading.value ||
              _.shoppingCartComplete == null,
          needScrollView: true,
          title: 'Planos',
          maxWidth: Responsive.maxWidth(),
          onRefresh: () async {
            await shoppingCartController.getShoppingCartItems();
          },
          bodyChild: GetBuilder<ShoppingCartController>(
            builder: (_) {
              if (_.shoppingCartItemsLoading.value) {
                return const PageLoadingWidget();
              }
              if (_.shoppingCartComplete != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.heightGap,
                    Text(
                      'Informações de pagamento',
                      style: Fonts.headlineMedium(context).copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    30.heightGap,
                    ...shoppingCartController.shoppingCartComplete!.items!
                        .map((e) => MonthlyFeeValues(monthlyFee: e)),
                    Visibility(
                      visible: Responsive.isTabletOrDesktop() &&
                          (!_.shoppingCartItemsLoading.value ||
                              _.shoppingCartComplete != null),
                      child: GetBuilder<ShoppingCartController>(builder: (_) {
                        return PrimaryButtonWidget(
                          onTap: () async {
                            if (_.shoppingCartPersons!.items!.firstWhereOrNull(
                                    (x) =>
                                        x.products!.firstWhereOrNull((y) =>
                                            y.hasFidelity! &&
                                            y.fidelityMonth != null) !=
                                        null) !=
                                null) {
                              Get.toNamed(Routes.campaignCartPlansWithFidelity);
                            } else {
                              Get.toNamed(
                                Routes.useTerms,
                                arguments: false,
                              );
                            }
                          },
                          titleButtom: 'Assinar plano',
                        );
                      }),
                    ),
                    120.heightGap
                  ],
                );
              }
              return TryAgainPage(
                message: 'Não foi possível carregar os dados do carrinho.',
                onTryAgain: () async {
                  await shoppingCartController.getShoppingCartItems();
                },
              );
            },
          ),
          bottomSheet: Visibility(
            visible: !Responsive.isTabletOrDesktop() &&
                (!_.shoppingCartItemsLoading.value ||
                    _.shoppingCartComplete != null),
            child: GetBuilder<ShoppingCartController>(builder: (_) {
              return BottomConfirmButton(
                onTap: () async {
                  if (_.shoppingCartPersons!.items!.firstWhereOrNull((x) =>
                          x.products!.firstWhereOrNull((y) =>
                              y.hasFidelity! && y.fidelityMonth != null) !=
                          null) !=
                      null) {
                    Get.toNamed(Routes.campaignCartPlansWithFidelity);
                  } else {
                    Get.toNamed(
                      Routes.useTerms,
                      arguments: false,
                    );
                  }
                },
                title: 'Assinar plano',
              );
            }),
          ),
        );
      },
    );
  }
}
