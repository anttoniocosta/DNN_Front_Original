import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class TotalResumeTiles extends StatelessWidget {
  const TotalResumeTiles({
    super.key,
    required this.complementName,
    required this.price,
  });

  final String complementName;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              complementName,
              style: Fonts.titleSmall(context).copyWith(
                overflow: TextOverflow.ellipsis,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                price.formatReal(),
                style: Fonts.titleSmall(context).copyWith(
                  color: AppColors.whiteColor,
                ),
              ).paddingOnly(right: 50),
            ),
          )
        ],
      ),
    ).paddingOnly(bottom: 10);
  }
}
