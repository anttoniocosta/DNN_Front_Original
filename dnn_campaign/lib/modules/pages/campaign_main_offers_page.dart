import 'package:dnn_campaign/dnn_campaign.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class CampaignMainOffersPage extends StatelessWidget {
  const CampaignMainOffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CampaignController>(
      builder: (controller) {
        return MobileLayout(
          needCenter: controller.campaignError != null ||
              controller.getCampaignLoading.value,
          needScrollView: true,
          title: 'Planos',
          maxWidth: Responsive.maxWidth(),
          onRefresh: () async => await controller.getCampaignsV3(),
          bodyChild: GetBuilder<CampaignController>(
            builder: (controller) {
              if (controller.getCampaignLoading.value) {
                return const CircularProgressIndicator();
              }
              if (controller.campaignError != null &&
                  controller.campaigns.isEmpty) {
                return TryAgainPage(
                  message: controller.campaignError!,
                  onTryAgain: () async => await controller.getCampaignsV3(),
                );
              }

              return const MainOffersListPartial();
            },
          ),
        );
      },
    );
  }
}
