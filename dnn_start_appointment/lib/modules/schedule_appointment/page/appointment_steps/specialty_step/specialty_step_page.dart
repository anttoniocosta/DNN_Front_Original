import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/widgets.dart';

class SpecialtyPageStep extends StatelessWidget {
  const SpecialtyPageStep({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Agendar consulta',
      maxWidth: Responsive.maxWidth(),
      bodyChild: GetBuilder<ScheduleController>(
        builder: (_) {
          return GetBuilder<StartAppointmentController>(
            builder: (startAppointment) {
              return Column(
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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      final priceList =
                          _.filterDaysList.map((e) => e.price).toList();
                      priceList.sort((a, b) => a!.compareTo(b!));
                      for (var event in _.filterDaysList) {
                        CalendarEvent dayEvent = CalendarEvent(
                          day: DateTime.parse(event.dateSchedule!),
                          uid: event.specialtyName!,
                          isLowCost: priceList.first! == event.price!,
                          price: event.price!,
                          acceptDnn: event.isAcceptsDnnPlan,
                        );
                        if (dayEvent.day.isSameDay(day)) {
                          return CalendarCellWithPrice(
                            dayEvent: dayEvent,
                            day: day,
                            hasPermission: startAppointment.hasPermission,
                            onTap: () async {
                              _.setScheduleSelectedDay(event);
                              _.setDate(event.dateSchedule!);
                              LoadingDialog.show(Get.context!);
                              await _.getFilterHours();
                              LoadingDialog.hide(Get.context!);
                              if (_.filterHourList.isNotEmpty) {
                                Get.toNamed(Routes.scheduleSpecialtyAble);
                              } else {
                                SnackbarCustom.snackbarError(
                                  'Houve um erro para trazer os dias tente novamente',
                                );
                              }
                            },
                          );
                        }
                      }
                      return StandartFormartCalendarCell(day: day);
                    },
                  ),
                  30.heightGap,
                ],
              );
            },
          );
        },
      ),
    );
  }
}
