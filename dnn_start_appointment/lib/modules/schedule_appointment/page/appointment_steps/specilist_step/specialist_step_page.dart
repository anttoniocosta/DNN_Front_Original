import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';
import 'package:dnn_shared/dnn_shared.dart';

class SpecialistPageStep extends StatelessWidget {
  const SpecialistPageStep({super.key});

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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CalendarSubtitle(
                  title: 'Dia disponível', color: AppColors.blueColor),
              CalendarSubtitle(
                title: 'Dia com menor preço',
                color: AppColors.blackDarkColor,
              ),
              CalendarSubtitle(
                title: 'Aceita plano DNN',
                color: AppColors.greenColor,
              ),
            ],
          ),
          16.heightGap,
          CalendarTableCustom(
            markerBuilder: (context, day, events) {
              for (CalendarEvent dayEvent in CalendarEvent.calendarList) {
                if (dayEvent.day.isSameDay(day)) {
                  return CalendarCellWithPrice(
                    dayEvent: dayEvent,
                    day: day,
                    onTap: () => Get.toNamed(Routes.scheduleSpecialistAble),
                  );
                }
              }
              return StandartFormartCalendarCell(day: day);
            },
          ),
          30.heightGap,
        ],
      ),
    );
  }
}
