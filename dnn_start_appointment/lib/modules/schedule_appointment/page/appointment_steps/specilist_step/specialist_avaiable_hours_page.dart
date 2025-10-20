import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';
import 'package:dnn_shared/dnn_shared.dart';

class SpecialistAvaiableHoursPage extends StatelessWidget {
  const SpecialistAvaiableHoursPage({super.key});

  _text({
    required String hour,
    required int consultsAvaiable,
    required double price,
    bool? isLowCost = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(hour,
            style: Fonts.titleMedium(Get.context!).copyWith(
              color: isLowCost! ? AppColors.whiteColor : null,
            )),
        Text('$consultsAvaiable consulta disponível',
            style: Fonts.bodyLarge(Get.context!).copyWith(
              overflow: TextOverflow.ellipsis,
              color: isLowCost ? AppColors.whiteColor : null,
            )),
        Text(price.formatReal(),
            style: Fonts.titleMedium(Get.context!).copyWith(
              color: isLowCost ? AppColors.whiteColor : null,
            )),
      ],
    );
  }

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
          // SpecialistCard(
          //   isSelected: true,
          //   specialist: SpecialistResponseModel(),
          // ),
          24.heightGap,
          Text(
            'Selecione o dia para agendamento:',
            style: Fonts.headlineMedium(context).copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          16.heightGap,
          const AppointmentRichText(
            title: 'Dia da consulta selecionada',
            content: '31/10/2023',
          ),
          16.heightGap,
          SearchResultTile(
            onTap: () => Get.toNamed(Routes.scheduleConfirm),
            child: _text(hour: '11:00', consultsAvaiable: 1, price: 70),
          ),
          SearchResultTile(
            bgColor: Get.isDarkMode
                ? AppColors.lighterblackLightColor
                : AppColors.blackDarkColor,
            onTap: () => Get.toNamed(Routes.scheduleConfirm),
            child: _text(
                hour: '12:00', consultsAvaiable: 1, price: 65, isLowCost: true),
          ),
          SearchResultTile(
            onTap: () => Get.toNamed(Routes.scheduleConfirm),
            child: _text(hour: '16:00', consultsAvaiable: 1, price: 70),
          ),
          16.heightGap,
        ],
      ),
    );
  }
}
