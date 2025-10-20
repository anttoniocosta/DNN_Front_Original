import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class MonthlyFeeValues extends StatelessWidget {
  const MonthlyFeeValues({super.key, required this.monthlyFee});

  final ShoppingCartItemsModel monthlyFee;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        rowText(
          context,
          title: monthlyFee.label!,
          price: monthlyFee.total!,
          needBold: true,
        ).paddingSymmetric(horizontal: 10),
        Divider(
          thickness: 1,
          color: !Get.isDarkMode
              ? AppColors.blackDarkColor
              : AppColors.lighterGreyColor,
        ),
        ...monthlyFee.items!.map(
          (e) {
            if (e.total == 0.0) return const SizedBox();
            return Column(
              children: [
                10.heightGap,
                rowText(
                  context,
                  title: e.person!.fullName!.capitalize!,
                  price: e.total!,
                  needBold: true,
                ).paddingSymmetric(horizontal: 10),
                ...e.products!.map(
                  (x) => rowText(
                    context,
                    title: x.title!,
                    price: x.price!,
                    needBold: false,
                  ).paddingOnly(left: 20, right: 10, bottom: 5, top: 10),
                )
              ],
            );
          },
        ),
      ],
    ).paddingOnly(bottom: 10);
  }

  Row rowText(
    BuildContext context, {
    required String title,
    required double price,
    required bool needBold,
    bool? hasDiscount = false,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: needBold
                ? Fonts.titleSmall(context)
                    .copyWith(overflow: TextOverflow.ellipsis)
                : Fonts.bodyLarge(context)
                    .copyWith(overflow: TextOverflow.ellipsis),
          ),
        ),
        10.widthGap,
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '${hasDiscount! ? '- ' : ''}${price.formatReal()}',
            style: needBold
                ? Fonts.titleSmall(context)
                : Fonts.bodyMedium(context),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
