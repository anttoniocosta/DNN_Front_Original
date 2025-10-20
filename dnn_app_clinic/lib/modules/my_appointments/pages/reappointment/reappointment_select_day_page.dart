import 'package:dnn_app_clinic/core/clinic/controller/my_appointments_controller.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class ReappointmentSelectDayPage extends StatelessWidget {
  const ReappointmentSelectDayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Consultas agendadas',
      bodyChild: GetBuilder<MyDoctorsAppointmentsController>(builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            10.heightGap,
            SpecialistCard(
              isSelected: true,
              crmNumber: _.rescheduleModel!.doctor!.crm,
              specialty: _.specialist!.specialtyName,
              fullName: _.rescheduleModel!.doctor!.name!.capitalize,
              price: _.rescheduleModel!.price!.toString(),
              clinicName: _.rescheduleModel!.clinic!.name!.capitalize,
            ),
            23.heightGap,
            Text(
              'Selecione o dia para reagendamento:',
              style: Fonts.headlineMedium(context).copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            32.heightGap,
            const CalendarSubtitle(
              title: 'Dia disponível',
              color: AppColors.blackDarkColor,
            ),
            16.heightGap,
            CalendarTableCustom(
              markerBuilder: (context, day, events) {
                for (var event in _.rescheduleModel!.dates!) {
                  final dayEvent = CalendarEvent(
                    day: DateTime.tryParse(event.date!)!,
                    uid: '',
                    isLowCost: true,
                    price: 1,
                  );

                  if (dayEvent.day.isSameDay(day)) {
                    return ScheduledSpecialistDayPrice(
                      dayEvent: dayEvent,
                      day: day,
                      onTap: () {
                        _.setRescheduleDateSelected(event);
                        Get.toNamed(Routes.reappoinmentSelectHour);
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
      }),
    );
  }
}
