import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class DependentResumeTile extends StatelessWidget {
  const DependentResumeTile({
    super.key,
    this.price,
    this.needByMonth,
    required this.onRemove,
    required this.name,
  });

  final VoidCallback onRemove;
  final String name;
  final String? price;
  final bool? needByMonth;

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
              name,
              style: Fonts.titleSmall(context).copyWith(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Row(
            children: [
              if (price != null)
                Text(
                  '${price!.formatReal()}${needByMonth != null && needByMonth == true ? '/mês' : ''}',
                  style: Fonts.titleSmall(context),
                ).paddingOnly(right: 10, top: 15, bottom: 15),
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
