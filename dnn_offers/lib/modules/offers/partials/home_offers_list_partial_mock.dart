import 'package:dnn_offers/mocks/offers_mock.dart';
import 'package:dnn_offers/modules/offers/export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeOffersListPartialMock extends StatefulWidget {
  const HomeOffersListPartialMock(
      {super.key, this.contentBeforeOffersList, this.title});

  final Widget? contentBeforeOffersList;
  final String? title;

  @override
  State<HomeOffersListPartialMock> createState() =>
      _HomeOffersListPartialMockState();
}

class _HomeOffersListPartialMockState extends State<HomeOffersListPartialMock> {
  final ScrollController secondScroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title ?? 'Ofertas para você.',
          style: Fonts.titleLarge(context),
          textAlign: TextAlign.center,
        ).paddingSymmetric(horizontal: 20),
        Scrollbar(
          controller: secondScroll,
          thickness: kIsWeb ? null : 0,
          child: SingleChildScrollView(
            controller: secondScroll,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                widget.contentBeforeOffersList ?? const SizedBox(width: 20),
                GetBuilder<OffersController>(builder: (_) {
                  return Row(
                    children: OffersModelMock.offerMockList.map((offer) {
                      return DisccountCardMock(
                        onTap: () async => _.getRedeOferta(path: offer.path),
                        offer: offer,
                      ).paddingOnly(right: 10);
                    }).toList(),
                  );
                }),
              ],
            ),
          ).paddingOnly(top: 20, bottom: kIsWeb ? 10 : 0),
        )
      ],
    );
  }
}
