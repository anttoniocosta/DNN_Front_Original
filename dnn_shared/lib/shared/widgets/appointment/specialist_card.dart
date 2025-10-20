import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class SpecialistCard extends StatelessWidget {
  const SpecialistCard({
    super.key,
    this.isSelected = false,
    this.specialist,
    this.onTap,
    this.crmNumber = 'Sem dados',
    this.specialty = 'Sem dados',
    this.fullName = 'Sem dados',
    this.price = 'Sem dados',
    this.clinicName = 'Sem dados',
  });

  final bool? isSelected;
  final VoidCallback? onTap;
  final SpecialistResponseModel? specialist;
  final String? crmNumber;
  final String? specialty;
  final String? fullName;
  final String? price;
  final String? clinicName;

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
              SpecialistHeaderInfos(
                isSelected: isSelected,
                crm: crmNumber ?? 'Sem dados',
                specialty: specialty!.capitalize ?? 'Sem dados',
                name: fullName!.capitalize ?? 'Sem dados',
              ).paddingSymmetric(horizontal: 10),
              AppointmentDivider(isSelected: isSelected)
                  .paddingSymmetric(horizontal: 20),
              Row(
                children: [
                  CardIconWidget(
                    cardColor: isSelected == true
                        ? AppColors.whiteColor
                        : Get.isDarkMode
                            ? AppColors.blackDarkColor
                            : AppColors.blueColor,
                    radius: 10,
                    icon: FontAwesomeIcons.laptopMedical,
                    iconColor: isSelected == true
                        ? AppColors.blueColor
                        : AppColors.whiteColor,
                  ).paddingOnly(right: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (appContext.type == AppTypeEnum.CLINIC) ...[
                        Text(
                          specialty!,
                          style: Fonts.titleMedium(context).copyWith(
                            color: isSelected == true
                                ? AppColors.whiteColor
                                : null,
                          ),
                        ),
                      ] else ...[
                        Text(
                          clinicName!,
                          style: Fonts.titleMedium(context).copyWith(
                            color: isSelected == true
                                ? AppColors.whiteColor
                                : null,
                          ),
                        ),
                      ],
                      AppointmentRichText(
                        title: 'Valor da consulta',
                        content: price != null
                            ? double.parse(price as String).formatReal()
                            : '',
                        isSelected: isSelected,
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
