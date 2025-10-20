import 'package:dnn_core/all_exports.dart';
import 'package:dnn_offers/modules/offers/export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeOffersListPartial extends StatefulWidget {
  const HomeOffersListPartial(
      {super.key, this.contentBeforeOffersList, this.title});

  final Widget? contentBeforeOffersList;
  final String? title;

  @override
  State<HomeOffersListPartial> createState() => _HomeOffersListPartialState();
}

class _HomeOffersListPartialState extends State<HomeOffersListPartial> {
  final ScrollController firstScroll = ScrollController();
  final ScrollController secondScroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        24.heightGap,
        Text(
          widget.title ?? 'Ofertas para você.',
          style: Fonts.titleLarge(context),
          textAlign: TextAlign.center,
        ).paddingSymmetric(horizontal: 20),
        GetBuilder<OffersController>(builder: (_) {
          if (_.isLoading.value) {
            return Scrollbar(
              controller: firstScroll,
              thickness: kIsWeb ? null : 0,
              child: SingleChildScrollView(
                controller: firstScroll,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.contentBeforeOffersList ?? const SizedBox(width: 20),
                    ...List.generate(
                      2,
                      (index) => Shimmer.fromColors(
                        baseColor: AppColors.shimmerBaseColor(),
                        highlightColor: AppColors.shimmerHighlithColor(),
                        child: Container(
                          width: 296,
                          height: 149,
                          decoration: BoxDecoration(
                            color: AppColors.lighterGreyColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ).paddingOnly(right: index == 0 ? 20 : 10),
                    )
                  ],
                ),
              ).paddingOnly(top: 20, bottom: kIsWeb ? 10 : 0),
            );
          }
          if (_.offers == null || _.offers!.offers!.isEmpty) {
            return NoOffersFoundWidget(
              contentBeforeOffersList: widget.contentBeforeOffersList,
            );
          }
          if (_.offers != null) {
            return Scrollbar(
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
                      if (_.isLoading.value) return const SizedBox();

                      return Row(
                        children: _.offers!.offers!
                            .where((x) => x.isHome!)
                            .map((offer) {
                          return DisccountCard(
                            segmentDisccount:
                                offer.discount!.toStringAsFixed(0),
                            segmentName: offer.title!.toUpperCase(),
                            backgroudColor: (Get.isDarkMode
                                ? offer.colorDark!.toColor()
                                : offer.color!.toColor()),
                            icon: offer.logo!,
                            onTap: () async => _.getRedeOferta(),
                          ).paddingOnly(right: 10);
                        }).toList(),
                      );
                    }),
                  ],
                ),
              ).paddingOnly(top: 20, bottom: kIsWeb ? 10 : 0),
            );
          }
          return const SizedBox();
        }),
      ],
    );
  }
}

class NoOffersFoundWidget extends StatelessWidget {
  const NoOffersFoundWidget({super.key, this.contentBeforeOffersList});

  final Widget? contentBeforeOffersList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Sem ofertas no momento para a sua região, fique atento as atualizações.',
          style: Fonts.bodyLarge(context),
        ).paddingSymmetric(horizontal: 20),
        10.heightGap,
        contentBeforeOffersList ?? const SizedBox(width: 20),
      ],
    );
  }
}
