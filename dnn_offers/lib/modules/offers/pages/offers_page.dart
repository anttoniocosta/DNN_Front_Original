import 'package:dnn_core/all_exports.dart';
import 'package:dnn_offers/modules/offers/export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OffersController>(
      builder: (_) {
        return MobileLayout(
          needCenter: _.isLoading.value || _.offers == null,
          needScrollView: true,
          title: 'Ofertas',
          onRefresh: () => _.getOffers(),
          bodyChild: GetBuilder<OffersController>(
            builder: (_) {
              if (_.isLoading.value) {
                return const PageLoadingWidget();
              }
              if (_.offers == null) {
                return TryAgainPage(
                  message:
                      'Ocorreu um erro ao recuperar suas ofertas, talvez você não possua conta ativa.',
                  onTryAgain: () async => _.getOffers(),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  14.heightGap,
                  if (_.offers!.person == null)
                    BuyCard(
                      onTap: () => Get.toNamed(Routes.campaignMainOffers),
                      width: double.infinity,
                    ),
                  if (_.offers!.person != null)
                    CardPerson(
                      person: _.offers!.person,
                    ),
                  24.heightGap,
                  ..._.offers!.offers!.map((offer) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                          Routes.offersPageDetails,
                          arguments: {'offer': offer},
                        );
                      },
                      child: CardOffer(offer: offer).paddingOnly(bottom: 16),
                    );
                  }),
                  if (_.offers!.person == null) ...[
                    Text(
                      'Ative seu plano para ter acesso a todos os descontos',
                      style: Fonts.headlineMedium(context),
                    )
                  ]
                ],
              );
            },
          ),
        );
      },
    );
  }
}
