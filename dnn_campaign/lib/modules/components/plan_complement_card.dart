import 'package:dnn_campaign/dnn_campaign.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class PlanComplementCard extends StatefulWidget {
  const PlanComplementCard({super.key, required this.campaign});

  final CampaignProductModel campaign;

  @override
  State<PlanComplementCard> createState() => _PlanComplementCardState();
}

class _PlanComplementCardState extends State<PlanComplementCard> {
  bool isChecked = false;

  Color highlightColor() {
    return (Get.isDarkMode
        ? AppColors.midBlackColor
        : AppColors.lighterGreyColor);
  }

  void onChecked() {
    setState(() => isChecked = !isChecked);
    campaignController.addComplementToList(isChecked, widget.campaign.id!);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChecked(),
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: Get.isDarkMode
              ? AppColors.midBlackColor
              : (isChecked
                  ? AppColors.greenSelectedCardColor
                  : AppColors.lighterGreyColor),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: Get.isDarkMode
                ? AppColors.midBlackColor
                : AppColors.lighterGreyColor,
          ),
        ),
        duration: const Duration(milliseconds: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            20.heightGap,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Adicionar complemento',
                  style: Fonts.bodySmall(context).copyWith(fontSize: 10),
                ),
                3.widthGap,
                SvgPicture.asset(
                  isChecked ? MediaRes.checkEnabled : MediaRes.checkDisabled,
                  width: 20,
                  height: 20,
                ),
              ],
            ).paddingSymmetric(horizontal: 20),
            12.heightGap,
            const Divider(
              thickness: 0.5,
              color: AppColors.darkGreyColor,
            ),
            PlanCardHeader(
              isHighlight: false,
              isSubscription: widget.campaign.isSubscription!,
              campaignTitle: widget.campaign.title!,
              price: widget.campaign.price!,
            ).paddingOnly(left: 20, right: 20),
            5.heightGap,
            Text(
              widget.campaign.descriptions!,
              style: Fonts.bodyLarge(context).copyWith(fontSize: 14),
            ).paddingOnly(left: 20, right: 20),
            BeneficitsSections(
              isHighlight: false,
              benefitsList: widget.campaign.benefitsList!,
            ),
          ],
        ),
      ),
    );
  }
}
