import 'package:flutter/material.dart';
import 'package:dnn_shared/dnn_shared.dart';

class SpecialtySelectSpecialistPage extends StatelessWidget {
  const SpecialtySelectSpecialistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Agendar consulta',
      maxWidth: Responsive.maxWidth(),
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          24.heightGap,
          Text(
            'Selecione o dia para agendamento:',
            style: Fonts.headlineMedium(context).copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          16.heightGap,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: 18, height: 18, color: AppColors.blackDarkColor),
              6.widthGap,
              const Flexible(
                child: AppointmentRichText(
                  title: 'O menor valor da consulta nesse dia',
                  content: '31/10/2023',
                ),
              )
            ],
          ),
          16.heightGap,
          // SpecialistCard(
          //   isSelected: true,
          //   specialist: SpecialistResponseModel(),
          //   onTap: () => Get.toNamed(Routes.scheduleConfirm),
          // ),
          // 16.heightGap,
          // SpecialistCard(
          //   isSelected: false,
          //   specialist: SpecialistResponseModel(),
          //   onTap: () => Get.toNamed(Routes.scheduleConfirm),
          // ),
          16.heightGap,
        ],
      ),
    );
  }
}
