import 'package:dnn_campaign/dnn_campaign.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class CampaignComplementsForDependentPage extends StatefulWidget {
  const CampaignComplementsForDependentPage({super.key});

  @override
  State<CampaignComplementsForDependentPage> createState() =>
      _CampaignComplementsForDependentPageState();
}

class _CampaignComplementsForDependentPageState
    extends State<CampaignComplementsForDependentPage> {
  @override
  void initState() {
    campaignController.complementsId.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CampaignController>(
      builder: (controller) {
        return MobileLayout(
          needCenter: controller.getComplementsLoading.value,
          needScrollView: true,
          title: 'Planos',
          maxWidth: Responsive.maxWidth(),
          onRefresh: () async => await controller.getComplementsV3(
            id: controller.complements.first.campaignProductsPrincipalId!,
          ),
          bodyChild: GetBuilder<CampaignController>(
            builder: (controller) {
              if (controller.getComplementsLoading.value) {
                return const PageLoadingWidget();
              }
              if (controller.complements.isEmpty) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    EmptyPageWidget(title: controller.campaignError!),
                    TextButton(
                      onPressed: () async => await controller.getComplementsV3(
                        id: controller
                            .complements.first.campaignProductsPrincipalId!,
                      ),
                      child: Text(
                        'Tente novamente',
                        style: Fonts.titleSmall(context),
                      ),
                    )
                  ],
                );
              }
              if (controller.campaigns.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.heightGap,
                    Text(
                      _subtitle(),
                      style: Fonts.headlineMedium(context).copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    10.heightGap,
                    Text(
                      _subtitle2(),
                      style: Fonts.bodyLarge(context),
                    ),
                    24.heightGap,
                    ...controller.complements.map(
                      (campaign) {
                        return PlanComplementCard(campaign: campaign)
                            .paddingOnly(bottom: 16);
                      },
                    ),
                    24.heightGap,
                    GetBuilder<ShoppingCartController>(builder: (_) {
                      return PrimaryButtonWidget(
                        isLoading:
                            shoppingCartController.addShoppingCartLoading.value,
                        onTap:
                            shoppingCartController.addShoppingCartLoading.value
                                ? null
                                : () async {
                                    await shoppingCartController
                                        .addShoppingCartDependent();
                                  },
                        titleButtom: 'Continuar',
                      );
                    }),
                    80.heightGap,
                  ],
                );
              }

              return const PageLoadingWidget();
            },
          ),
        );
      },
    );
  }

  String _subtitle() {
    switch (appContext.type) {
      case AppTypeEnum.CLIENT:
        return 'Vamos complementar o plano do seu dependente?';
      case AppTypeEnum.COMPANY:
        return 'Vamos complementar o plano do seu colaborar ou do dependente dele?';
      default:
        return 'Vamos complementar o plano do seu dependente?';
    }
  }

  String _subtitle2() {
    switch (appContext.type) {
      case AppTypeEnum.CLIENT:
        return 'Adicione os complementos necessário para o plano do seu dependente:';
      case AppTypeEnum.COMPANY:
        return 'Adicione os complementos necessário para o plano do seu colaborar ou do dependente dele:';
      default:
        return 'Adicione os complementos necessário para o plano do seu dependente:';
    }
  }
}
