import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class ClinicCard extends StatelessWidget {
  const ClinicCard({
    super.key,
    this.isSelected = false,
    required this.clinicModel,
    this.onTap,
  });

  final bool? isSelected;
  final ClinicViewModel clinicModel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: isSelected == true ? null : onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected == true
                ? AppColors.blackDarkColor
                : Get.isDarkMode
                    ? AppColors.lighterblackLightColor
                    : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: highElevation + highElevationTwo,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                clinicModel.name,
                style: Fonts.titleLarge(context).copyWith(
                  color: isSelected == true ? AppColors.whiteColor : null,
                ),
              ).paddingOnly(left: 10),
              AppointmentDivider(isSelected: isSelected).paddingOnly(left: 10),
              Row(
                children: [
                  CardIconWidget(
                    cardColor: Get.isDarkMode
                        ? AppColors.blackDarkColor
                        : AppColors.whiteColor,
                    radius: 10,
                    icon: FontAwesomeIcons.laptopMedical,
                    iconColor: Get.isDarkMode
                        ? AppColors.whiteColor
                        : AppColors.blueColor,
                  ).paddingOnly(right: 16),
                  ClinicAddressInfos(
                    needSeeMap: false,
                    isSelected: isSelected,
                    street: clinicModel.street,
                    neighborhood: clinicModel.neighborhood,
                    city: clinicModel.city,
                    state: clinicModel.state,
                    zipCode: clinicModel.zipCode,
                    number: clinicModel.number,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
