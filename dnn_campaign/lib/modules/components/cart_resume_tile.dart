import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class CartResumeTiles extends StatelessWidget {
  const CartResumeTiles({
    super.key,
    required this.onRemove,
    required this.complementName,
    required this.price,
    this.needByMonth = true,
    this.fidelityMonth,
  });

  final VoidCallback onRemove;
  final String complementName;
  final double price;
  final bool? needByMonth;
  final int? fidelityMonth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? AppColors.midBlackColor
            : AppColors.defaultBackgroundCardColor,
        boxShadow: highElevation,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              complementName,
              style: Fonts.titleSmall(context).copyWith(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                '${price.formatReal()}${needByMonth! ? '/mês' : ''}',
                style: Fonts.titleSmall(context),
              ).paddingOnly(right: 10, top: 15, bottom: 15),
              if (fidelityMonth == null)
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: onRemove,
                  icon: const FaIcon(
                    FontAwesomeIcons.solidCircleXmark,
                    color: AppColors.redColor,
                    size: 18,
                  ),
                )
            ],
          )
        ],
      ),
    ).paddingOnly(bottom: 10);
  }
}
