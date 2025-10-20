import 'package:dnn_campaign/dnn_campaign.dart';
import 'package:flutter/material.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';

class MainOffersListPartial extends StatefulWidget {
  const MainOffersListPartial({super.key});

  @override
  State<MainOffersListPartial> createState() => _MainOffersListPartialState();
}

class _MainOffersListPartialState extends State<MainOffersListPartial> {
  @override
  void initState() {
    campaignController.clearChoicedPlans();
    shoppingCartController.getShoppingCart();
    super.initState();
  }

  @override
  void dispose() {
    campaignController.clearChoicedPlans();
    super.dispose();
  }

  Future<void> onContinue(CampaignProductModel campaign) async {
    switch (appContext.type) {
      case AppTypeEnum.CLIENT:
        if (campaign.hasComplements!) {
          campaignController.getComplementsV3(id: campaign.id!);
          Get.toNamed(Routes.campaignComplementsOffers);
        } else {
          if (navigationController.isLogged) {
            await shoppingCartController.addShoppingCartMain();
          } else {
            Get.toNamed(Routes.campaignPersonalInfos);
          }
        }
        break;
      case AppTypeEnum.COMPANY:
        if (campaign.hasComplements!) {
          campaignController.getComplementsV3(id: campaign.id!);
          Get.toNamed(Routes.campaignComplementsOffers);
        } else {
          Get.toNamed(Routes.campaignPersonalInfos);
        }
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CampaignController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.heightGap,
          Text('Assinar Planos', style: Fonts.titleSmall(context)),
          Text('Escolha o melhor plano para você!',
              style: Fonts.bodyLarge(context).copyWith(
                fontSize: 16,
              )),
          24.heightGap,
          ...controller.campaigns.where((e) => e.level == 1).map(
            (campaign) {
              if (campaign.isSubscription!) {
                return PlanOfferCard(
                  campaign: campaign,
                  mainOnTap: () async {
                    controller.planId = campaign.id!;
                    if (campaign.useTermsCustom != null) {
                      storage.savePlanId(campaign.id!);
                      storage.savePayTerm(campaign.useTermsCustom!);
                    } else {
                      storage.removePayTerm();
                    }
                    storage.saveGatewayList(campaign.gateways!);
                    onContinue(campaign);
                  },
                  mainButtonTitle: campaign.isSubscription!
                      ? 'Assinar Plano'
                      : 'Comprar Consulta',
                ).paddingOnly(bottom: 24);
              }
              return const SizedBox.shrink();
            },
          ).toList(),
          24.heightGap,
        ],
      );
    });
  }
}
