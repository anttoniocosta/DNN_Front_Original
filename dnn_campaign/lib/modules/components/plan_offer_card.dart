import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class PlanOfferCard extends StatefulWidget {
  const PlanOfferCard({
    super.key,
    required this.mainOnTap,
    required this.mainButtonTitle,
    required this.campaign,
  });

  final VoidCallback mainOnTap;
  final String mainButtonTitle;
  final CampaignProductModel campaign;

  @override
  State<PlanOfferCard> createState() => _PlanOfferCardState();
}

class _PlanOfferCardState extends State<PlanOfferCard> {
  bool beneficifIsOpen = false;

  void setOpen() => setState(() => beneficifIsOpen = !beneficifIsOpen);

  Color highlightColor() {
    return widget.campaign.flgHighlight!
        ? (Get.isDarkMode ? AppColors.lighterblackLightColor : Colors.black)
        : (Get.isDarkMode
            ? AppColors.midBlackColor
            : AppColors.lighterGreyColor);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topLeft,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(14, 18, 14, 0),
          decoration: BoxDecoration(
            color: highlightColor(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PlanCardHeader(
                isHighlight: widget.campaign.flgHighlight!,
                isSubscription: widget.campaign.isSubscription!,
                campaignTitle: widget.campaign.title!,
                price: widget.campaign.price!,
              ),
              19.heightGap,
              Text(
                widget.campaign.descriptions!,
                style: Fonts.bodyLarge(context).copyWith(
                  color: widget.campaign.flgHighlight!
                      ? AppColors.whiteColor
                      : null,
                  fontSize: 16,
                ),
                textAlign: TextAlign.start,
              ),
              32.heightGap,
              PrimaryButtonWidget(
                onTap: widget.mainOnTap,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.mainButtonTitle,
                      style: Fonts.titleMedium(context).copyWith(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    widget.campaign.flgHighlight!
                        ? Text(
                            '(O mais vantajoso)',
                            style: Fonts.bodyMedium(context).copyWith(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : Container()
                  ],
                ),
              ),
              BeneficitsSections(
                isHighlight: widget.campaign.flgHighlight!,
                benefitsList: widget.campaign.benefitsList!,
              ),
            ],
          ),
        ),
        if (widget.campaign.flgHighlight!)
          const Positioned(
            top: -26,
            right: -12,
            child: CampaginCardBadge(),
          ),
      ],
    );
  }
}

class PlanCardHeader extends StatelessWidget {
  const PlanCardHeader(
      {super.key,
      required this.isHighlight,
      required this.isSubscription,
      required this.campaignTitle,
      this.price});

  final bool isHighlight;
  final bool isSubscription;
  final String campaignTitle;
  final double? price;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          campaignTitle,
          style: Fonts.titleSmall(context).copyWith(
            color: isHighlight ? AppColors.whiteColor : null,
            fontSize: 14,
          ),
        )),
        price == null
            ? Container()
            : Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: price!.formatReal(),
                          style: Fonts.titleSmall(context).copyWith(
                            color: isHighlight ? AppColors.whiteColor : null,
                            fontSize: 25,
                          ),
                        ),
                        TextSpan(
                          text: !isSubscription ? '' : '/mês',
                          style: Fonts.titleSmall(context).copyWith(
                            color: isHighlight ? AppColors.whiteColor : null,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}

class BeneficitsSections extends StatefulWidget {
  const BeneficitsSections(
      {super.key, required this.isHighlight, this.benefitsList});

  final bool isHighlight;
  final List<String>? benefitsList;

  @override
  State<BeneficitsSections> createState() => _BeneficitsSectionsState();
}

class _BeneficitsSectionsState extends State<BeneficitsSections> {
  bool beneficifIsOpen = false;

  void setOpen() => setState(() => beneficifIsOpen = !beneficifIsOpen);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: beneficifIsOpen == false,
          replacement: 30.heightGap,
          child: ShowMoreActions(
            isMainOffer: widget.isHighlight,
            title: 'Conheça os Benefícios',
            icon: FontAwesomeIcons.caretDown,
            onTap: () => setOpen(),
          ),
        ),
        Visibility(
          visible: beneficifIsOpen == true,
          child: Column(
            children: widget.benefitsList!
                .map(
                  (e) => Row(
                    children: [
                      const FaIcon(FontAwesomeIcons.solidCircleCheck,
                          color: AppColors.blueColor),
                      14.widthGap,
                      Expanded(
                        child: Text(
                          e,
                          style: Fonts.bodyLarge(context).copyWith(
                            color: widget.isHighlight
                                ? AppColors.whiteColor
                                : null,
                          ),
                        ),
                      )
                    ],
                  ).paddingOnly(bottom: 10),
                )
                .toList(),
          ).paddingSymmetric(horizontal: 20),
        ),
        Visibility(
          visible: beneficifIsOpen == true,
          child: ShowMoreActions(
            isMainOffer: widget.isHighlight,
            title: 'Ocultar os Benefícios',
            icon: FontAwesomeIcons.caretUp,
            onTap: () => setOpen(),
          ),
        ),
      ],
    );
  }
}

class CampaginCardBadge extends StatelessWidget {
  const CampaginCardBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Image.asset(MediaRes.moreAdvantageous),
    );
  }
}

class ShowMoreActions extends StatelessWidget {
  const ShowMoreActions({
    super.key,
    required this.isMainOffer,
    required this.title,
    required this.icon,
    required this.onTap,
    this.padding = 24,
  });

  final bool isMainOffer;
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Fonts.titleLarge(context).copyWith(
                  color: isMainOffer ? AppColors.whiteColor : null,
                  fontSize: 14,
                ),
              ),
              10.widthGap,
              FaIcon(
                icon,
                color:
                    isMainOffer || Get.isDarkMode ? AppColors.whiteColor : null,
              ),
            ],
          ).paddingSymmetric(vertical: padding),
        ],
      ),
    );
  }
}
