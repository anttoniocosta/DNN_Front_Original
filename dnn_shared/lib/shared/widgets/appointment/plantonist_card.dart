import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class PlantonistCard extends StatelessWidget {
  const PlantonistCard({
    super.key,
    this.isSelected = false,
    this.onTap,
    this.specialty,
    this.price,
  });

  final bool? isSelected;
  final VoidCallback? onTap;
  final String? specialty;
  final String? price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected == true
                ? AppColors.blackDarkColor
                : (Get.isDarkMode
                    ? AppColors.lighterblackLightColor
                    : AppColors.whiteColor),
            borderRadius: BorderRadius.circular(20),
            boxShadow: highElevation + highElevationTwo,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CardIconWidget(
                    cardColor: isSelected == true
                        ? AppColors.whiteColor
                        : Get.isDarkMode
                            ? AppColors.blackDarkColor
                            : AppColors.blueColor,
                    radius: 12,
                    iconSize: 36,
                    icon: FontAwesomeIcons.laptopMedical,
                    iconColor: isSelected == true
                        ? AppColors.blueColor
                        : AppColors.whiteColor,
                  ).paddingOnly(right: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PRONTO ATENDIMENTO',
                        style: Fonts.titleMedium(context).copyWith(
                          color:
                              isSelected == true ? AppColors.whiteColor : null,
                        ),
                      ),
                      Text(
                        specialty!,
                        style: Fonts.displaySmall(context).copyWith(
                          color:
                              isSelected == true ? AppColors.whiteColor : null,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
