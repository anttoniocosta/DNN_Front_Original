import 'package:dnn_campaign/dnn_campaign.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class CampaignMainOffersForDependentPage extends StatefulWidget {
  const CampaignMainOffersForDependentPage({super.key});

  @override
  State<CampaignMainOffersForDependentPage> createState() =>
      _CampaignMainOffersForDependentPageState();
}

class _CampaignMainOffersForDependentPageState
    extends State<CampaignMainOffersForDependentPage> {
  @override
  void initState() {
    campaignController.clearChoicedPlans();
    super.initState();
  }

  @override
  void dispose() {
    campaignController.clearChoicedPlans();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CampaignController>(
      builder: (controller) {
        return MobileLayout(
          needCenter: controller.campaignError != null ||
              controller.getCampaignLoading.value,
          needScrollView: true,
          maxWidth: Responsive.maxWidth(),
          title: 'Planos',
          onRefresh: () async => await controller.getCampaigns(),
          bodyChild: GetBuilder<CampaignController>(
            builder: (controller) {
              if (controller.getCampaignLoading.value) {
                return const CircularProgressIndicator();
              }
              if (controller.campaignError != null &&
                  controller.campaigns.isEmpty) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    EmptyPageWidget(title: controller.campaignError!),
                    TextButton(
                      onPressed: () async => await controller.getCampaigns(),
                      child: Text(
                        'Tente novamente',
                        style: Fonts.titleSmall(context),
                      ),
                    )
                  ],
                );
              }

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
                  24.heightGap,
                  ...controller.campaigns.where((e) => e.level == 1).map(
                    (campaign) {
                      return PlanOfferCard(
                        campaign: campaign,
                        mainOnTap: () async {
                          controller.planId = campaign.id!;
                          storage.saveGatewayList(campaign.gateways!);
                          if (campaign.hasComplements!) {
                            controller.getComplementsV3(id: campaign.id!);
                            Get.toNamed(
                                Routes.campaignComplementsOffersForDependent);
                          } else {
                            await shoppingCartController
                                .addShoppingCartDependent();
                            Get.toNamed(Routes.campaignCartResume);
                          }
                        },
                        mainButtonTitle: campaign.isSubscription!
                            ? 'Assinar Plano'
                            : 'Comprar Consulta',
                      ).paddingOnly(bottom: 24);
                    },
                  ),
                  24.heightGap,
                ],
              );
            },
          ),
        );
      },
    );
  }

  String _subtitle() {
    switch (appContext.type) {
      case AppTypeEnum.CLIENT:
        return 'Escolha o melhor plano para o seu dependente!';
      case AppTypeEnum.COMPANY:
        return 'Escolha o melhor plano para o seu colaborador o para o dependente dele!';
      default:
        return 'Escolha o melhor plano para o seu dependente!';
    }
  }
}
