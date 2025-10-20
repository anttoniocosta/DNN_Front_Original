import 'package:dnn_core/core/extensions/export.dart';
import 'package:dnn_offers/modules/offers/export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CardPerson extends StatelessWidget {
  const CardPerson({
    super.key,
    this.person,
  });

  final OffersPersonModel? person;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: (person!.isActive!)
            ? (Get.isDarkMode
                ? AppColors.midBlackColor
                : AppColors.blackDarkColor)
            : AppColors.redColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  person!.document!.formatDocument(),
                  style: Fonts.titleLarge(context).copyWith(
                    color: AppColors.whiteColor,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 20,
                  ),
                ),
              ),
              SvgPicture.asset(
                MediaRes.horizontalBranco,
                width: 60,
              )
            ],
          ),
          17.heightGap,
          Text(
            person!.name!,
            style: Fonts.titleLarge(context).copyWith(
              color: AppColors.whiteColor,
              overflow: TextOverflow.ellipsis,
              fontSize: 20,
            ),
          ),
          8.heightGap,
          if (person!.isActive!) ...[
            Text(
              'Ativo',
              style: Fonts.bodyLarge(context).copyWith(
                color: AppColors.whiteColor,
                fontSize: 14,
              ),
            ),
            Text(
              person!.validate!,
              style: Fonts.titleLarge(context).copyWith(
                color: AppColors.whiteColor,
                overflow: TextOverflow.ellipsis,
                fontSize: 20,
              ),
            )
          ] else ...[
            Text(
              'Inativo',
              style: Fonts.titleLarge(context).copyWith(
                color: AppColors.whiteColor,
                overflow: TextOverflow.ellipsis,
                fontSize: 36,
              ),
            ).paddingOnly(top: 10),
          ]
        ],
      ),
    );
  }
}
