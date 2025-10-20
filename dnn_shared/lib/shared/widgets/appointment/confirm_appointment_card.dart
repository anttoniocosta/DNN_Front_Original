import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class ConfirmAppointmentCard extends StatelessWidget {
  const ConfirmAppointmentCard({
    super.key,
    this.isSelected = false,
    required this.clinicModel,
    this.onTap,
    required this.specialist,
    this.schedule,
  });

  final bool? isSelected;
  final ClinicViewModel clinicModel;
  final SpecialistResponseModel specialist;
  final VoidCallback? onTap;

  final ScheduleFilterHourResponse? schedule;

  String returnHour(String e) {
    final hour = e.split('T').last.split(':');
    hour.removeLast();
    return hour.join(':');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: isSelected == true ? null : onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected == true
                ? AppColors.blackDarkColor
                : (Get.isDarkMode
                    ? AppColors.midBlackColor
                    : AppColors.whiteColor),
            borderRadius: BorderRadius.circular(20),
            boxShadow: highElevation + highElevationTwo,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpecialistHeaderInfos(
                isSelected: isSelected,
                crm: schedule!.crmNumber ?? '',
                specialty: schedule!.specialtyName ?? '',
                name: schedule!.specialistName?.capitalize ?? '',
              ),
              AppointmentDivider(isSelected: isSelected),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    schedule!.clinicName?.capitalize ?? '',
                    style: Fonts.titleLarge(context).copyWith(
                      color: isSelected == true ? AppColors.whiteColor : null,
                    ),
                  ),
                  10.heightGap,
                  Row(
                    children: [
                      CardIconWidget(
                        cardColor: isSelected == true
                            ? AppColors.whiteColor
                            : AppColors.blueColor,
                        radius: 10,
                        icon: FontAwesomeIcons.laptopMedical,
                        iconColor: isSelected == true
                            ? AppColors.blueColor
                            : AppColors.whiteColor,
                      ),
                      22.widthGap,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppointmentRichText(
                            title: 'Data',
                            content:
                                schedule!.dateSchedule!.formatDateFromIso(),
                          ),
                          AppointmentRichText(
                            title: 'Hora',
                            content: returnHour(schedule!.dateSchedule!),
                          ),
                          AppointmentRichText(
                            title: 'Valor da Consulta',
                            content: schedule!.price!.formatReal(),
                          ),
                          AppointmentRichText(
                            title: 'Tipo de consulta:',
                            content: schedule!.typeScheduleName!,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ).paddingSymmetric(vertical: 16),
              AppointmentDivider(isSelected: isSelected),
              ClinicAddressInfos(
                needSeeMap: false,
                isSelected: isSelected,
                street: schedule!.clinicAddress!,
                neighborhood: schedule!.clinicNeighborhood!,
                city: schedule!.clinicCity!,
                state: schedule!.clinicState!,
                zipCode: schedule!.clinicZipcode!,
                number: schedule!.clinicNumber!,
              ),
              20.heightGap,
            ],
          ),
        ),
      ),
    );
  }
}
