import 'package:dnn_core/core/export.dart';
import 'package:dnn_core/dnn_core.dart';
import 'package:dnn_core/modules/navigation/navigation_controller.dart';
import 'package:dnn_offers/dnn_offers.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class OfferDetailPage extends StatelessWidget {
  OfferDetailPage({super.key});

  final OffersModel offer = Get.arguments['offer'];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OffersController>(
      builder: (_) {
        return MobileLayout(
          needCenter: false,
          needScrollView: true,
          title: 'Ofertas',
          bodyChild: GetBuilder<OffersController>(
            builder: (_) {
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
                  CardOffer(offer: offer).paddingOnly(bottom: 10),
                  HtmlWidget(
                    offer.descriptions!,
                    textStyle: Fonts.bodyLarge(context)
                        .copyWith(overflow: TextOverflow.ellipsis),
                  ),
                ],
              );
            },
          ),
          bottomNavigationBar: BottomConfirmButton(
            title: 'Voltar ao início',
            onTap: () {
              navigationController.setIndex(NavigationTabs.home);
              Get.offAllNamed(Routes.basePage);
            },
          ),
        );
      },
    );
  }
}
