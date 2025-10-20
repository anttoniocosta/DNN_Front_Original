import 'package:dnn_campaign/dnn_campaign.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class CampaignComplementsPage extends StatefulWidget {
  const CampaignComplementsPage({super.key});

  @override
  State<CampaignComplementsPage> createState() =>
      _CampaignComplementsPageState();
}

class _CampaignComplementsPageState extends State<CampaignComplementsPage> {
  @override
  void initState() {
    campaignController.complementsId.clear();
    super.initState();
  }

  Future<void> onContinue() async {
    switch (appContext.type) {
      case AppTypeEnum.CLIENT:
        if (navigationController.isLogged) {
          await shoppingCartController.addShoppingCartMain();
        } else {
          Get.toNamed(Routes.campaignPersonalInfos);
        }
        break;
      case AppTypeEnum.COMPANY:
        Get.toNamed(Routes.campaignPersonalInfos);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CampaignController>(
      builder: (_) {
        return MobileLayout(
          needCenter: _.getComplementsLoading.value || _.campaigns.isEmpty,
          needScrollView: true,
          title: 'Complemente o Plano',
          maxWidth: Responsive.maxWidth(),
          onRefresh: () async => await _.getComplementsV3(
              id: _.complements.first.campaignProductsPrincipalId!),
          bodyChild: GetBuilder<CampaignController>(
            builder: (_) {
              if (_.getComplementsLoading.value) {
                return const PageLoadingWidget();
              }

              if (_.complements.isEmpty) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    EmptyPageWidget(title: _.campaignError!),
                    TextButton(
                      onPressed: () async => await _.getComplementsV3(
                          id: _.complements.first.campaignProductsPrincipalId!),
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
                  20.heightGap,
                  Text(
                    'Complemente seu plano',
                    style: Fonts.headlineMedium(context).copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  10.heightGap,
                  Text(
                    'Adicione os complementos necessários:',
                    style: Fonts.bodyLarge(context).copyWith(
                      fontSize: 15,
                    ),
                  ),
                  24.heightGap,
                  ..._.complements.map(
                    (campaign) {
                      return PlanComplementCard(
                        campaign: campaign,
                      ).paddingOnly(bottom: 16);
                    },
                  ),
                  24.heightGap,
                  Visibility(
                    visible: Responsive.isTabletOrDesktop(),
                    child: GetBuilder<ShoppingCartController>(builder: (_) {
                      return PrimaryButtonWidget(
                        onTap: onContinue,
                        titleButtom: 'Continuar',
                        height: 50,
                        fontSize: 16,
                      ).paddingOnly(bottom: 24);
                    }),
                  ),
                  80.heightGap,
                ],
              );
            },
          ),
          bottomNavigationBar: Visibility(
            visible: !Responsive.isTabletOrDesktop(),
            child: GetBuilder<ShoppingCartController>(builder: (_) {
              return PrimaryButtonWidget(
                onTap: onContinue,
                titleButtom: 'Continuar',
                height: 50,
                fontSize: 16,
              ).paddingAll(24);
            }),
          ),
        );
      },
    );
  }
}
