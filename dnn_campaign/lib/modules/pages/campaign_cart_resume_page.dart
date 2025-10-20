import 'package:dnn_campaign/dnn_campaign.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';

import 'package:flutter/material.dart';

class CampaignCartResumePage extends StatelessWidget {
  const CampaignCartResumePage({super.key});

  bool isLoadingOrEmpty() {
    return (shoppingCartController.shoppingCartPersonsLoading.value ||
        shoppingCartController.shoppingCartPersons == null ||
        shoppingCartController.shoppingCartPersons!.items!.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShoppingCartController>(
      builder: (_) {
        return MobileLayout(
          needCenter: isLoadingOrEmpty(),
          needScrollView: true,
          title: 'Resumo dos produtos',
          maxWidth: Responsive.maxWidth(),
          onRefresh: () async {
            await shoppingCartController.getShoppingCartPersons();
          },
          appBarLeading: Navigator.canPop(context)
              ? null
              : IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    navigationController.setIndex(NavigationTabs.home);
                    Get.toNamed(Routes.basePage);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 22,
                    color: Get.isDarkMode ? AppColors.whiteColor : Colors.black,
                  ),
                ),
          bodyChild: GetBuilder<ShoppingCartController>(
            builder: (_) {
              if (_.shoppingCartPersonsLoading.value) {
                return const CircularProgressIndicator.adaptive();
              }

              if (_.shoppingCartPersons != null &&
                  _.shoppingCartPersons!.items!.isNotEmpty) {
                final persons = _.shoppingCartPersons;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.heightGap,
                    ...persons!.items!.map((person) {
                      if (person.total == 0.0) return const SizedBox();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Text(
                                    person.person!.fullName!.capitalize!,
                                    style:
                                        Fonts.headlineMedium(context).copyWith(
                                      fontWeight: FontWeight.w700,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          12.heightGap,
                          ...person.products!.map(
                            (product) => CartResumeTiles(
                              fidelityMonth: product.fidelityMonth,
                              needByMonth: product.isSubscription,
                              complementName: product.productName!,
                              price: product.productPrice!,
                              onRemove: () async {
                                shoppingCartController.deleteShoppidngCartPlan(
                                  personId: person.person!.personId!,
                                  planId: product.productId!,
                                );
                              },
                            ),
                          ),
                          TotalResumeTiles(
                            complementName: 'Total',
                            price: person.total!,
                          ),
                        ],
                      );
                    }),
                    32.heightGap,
                    Text(
                      'Total da compra',
                      style: Fonts.headlineMedium(context).copyWith(
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    10.heightGap,
                    TotalResumeTiles(
                      complementName: 'Total',
                      price: (persons.items!
                          .map((e) => e.total)
                          .toList()
                          .reduce((a, b) => a! + b!)!),
                    ),
                    10.heightGap,
                    _terms(context),
                    10.heightGap,
                    Visibility(
                      visible:
                          Responsive.isTabletOrDesktop() && !isLoadingOrEmpty(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          10.heightGap,
                          SecondaryButtonWidget(
                            onTap: () => Get.toNamed(
                              Routes.campaignDependentPersonalInfos,
                            ),
                            titleButtom: 'Adicionar dependente',
                          ),
                          10.heightGap,
                          GetBuilder<ShoppingCartController>(builder: (_) {
                            return PrimaryButtonWidget(
                              isLoading: _.shoppingCartItemsLoading.value,
                              onTap: () async {
                                await _.getShoppingCartItems();
                                Get.toNamed(Routes.campaignCartConfirm);
                              },
                              titleButtom: _.pendingDependents.isEmpty
                                  ? 'Continuar sem adicionar dependente'
                                  : 'Continuar',
                            );
                          }),
                          10.heightGap,
                        ],
                      ).paddingOnly(top: 20),
                    ),
                    220.heightGap,
                  ],
                );
              }
              return TryAgainPage(
                message:
                    'Não foi possível carregar os dados do resumo da sua compra.',
                onTryAgain: () async {
                  await shoppingCartController.getShoppingCartPersons();
                },
              );
            },
          ),
          bottomSheet: Visibility(
            visible: !Responsive.isTabletOrDesktop() && !isLoadingOrEmpty(),
            child: GetBuilder<ShoppingCartController>(builder: (_) {
              return BottomTwoActionsButton(
                onTapSecond: () async {
                  await _.getShoppingCartItems();
                  Get.toNamed(Routes.campaignCartConfirm);
                },
                titleSecond: _btnContinueText(_.pendingDependents.isNotEmpty),
                isLoadingSecond: _.shoppingCartItemsLoading.value,
                onTapThird: () async => {
                  await _.deleteShoppingCart(),
                  Get.back(),
                  Get.back(),
                  Get.back(),
                  Get.back(),
                },
                titleThird: 'Cancelar',
                isLoadingThird: _.deleteShoppingCartLoading.value,
                onTapFirst: () {
                  Get.toNamed(Routes.campaignDependentPersonalInfos);
                },
                titleFirst: _btnAddText(),
              );
            }),
          ),
        );
      },
    );
  }

  String _btnAddText() {
    switch (appContext.type) {
      case AppTypeEnum.CLIENT:
        return 'Adicionar dependente';
      case AppTypeEnum.COMPANY:
        return 'Adicionar colaborador/dependente';
      default:
        return 'Adicionar dependente';
    }
  }

  String _btnContinueText(bool hasDependents) {
    switch (appContext.type) {
      case AppTypeEnum.CLIENT:
        return hasDependents
            ? 'Continuar'
            : 'Continuar sem adicionar dependente';
      case AppTypeEnum.COMPANY:
        return 'Continuar sem adicionar';
      default:
        return 'Continuar sem adicionar dependente';
    }
  }

  Widget _terms(context) {
    return GestureDetector(
      onTap: () => {
        Get.toNamed(
          Routes.useTerms,
          arguments: true,
        )
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Clicando em continuar você aceita',
              style: Fonts.bodyLarge(context).copyWith(
                color: AppColors.secondaryTextColor,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('os ',
                  style: Fonts.bodyLarge(context).copyWith(
                    color: AppColors.secondaryTextColor,
                  )),
              Text(
                'Termos e Políticas do Sistema',
                style: Fonts.bodyLarge(context).copyWith(
                  color: AppColors.blueColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
