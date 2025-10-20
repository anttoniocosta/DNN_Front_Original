import 'package:dnn_app_clinic/core/core.dart';
import 'package:dnn_app_clinic/modules/my_appointments/export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectDayAppointmentPartial extends StatefulWidget {
  const SelectDayAppointmentPartial({
    super.key,
    required this.onContinue,
    required this.titlePage,
    required this.contentTitle,
  });

  final VoidCallback onContinue;
  final String titlePage;
  final String contentTitle;

  @override
  State<SelectDayAppointmentPartial> createState() =>
      _SelectDayAppointmentPartialState();
}

class _SelectDayAppointmentPartialState
    extends State<SelectDayAppointmentPartial> {
  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: widget.titlePage,
      bodyChild: GetBuilder<MyDoctorsAppointmentsController>(builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.heightGap,
            SpecialistCard(
              clinicName: _.specialist!.clinic!.fullName,
              specialist: _.specialist,
              specialty: _.specialist!.specialtyName,
              price: _.specialist!.price!.toString(),
              fullName: _.specialist!.doctor!.fullName,
              crmNumber: _.specialist!.doctor!.crmNumber,
              isSelected: true,
            ),
            24.heightGap,
            Text(
              widget.contentTitle,
              style: Fonts.headlineMedium(context),
            ),
            24.heightGap,
            CalendarTableCustom(
              firstDayCalendar: DateTime.utc(2024, 1, 1),
              markerBuilder: (context, day, events) {
                for (final event in _.myAppointments) {
                  if (DateTime.tryParse(event.date!)!.isSameDay(day)) {
                    final dayEvent = CalendarEvent(
                      day: DateTime.parse(event.date!),
                      uid: '',
                      isLowCost: true,
                      price: 1,
                    );
                    return ScheduledSpecialistDayPrice(
                      dayEvent: dayEvent,
                      day: day,
                      onTap: () {
                        _.setSelectedDate(event);
                        switch (_.status!.id!) {
                          case AppointmentsStatusEnum.agendada:
                            Get.toNamed(Routes.appointmentedSelectHour);
                            break;
                          case AppointmentsStatusEnum.realizado:
                          case AppointmentsStatusEnum.naoRealizado:
                            Get.toNamed(Routes.finishedSelectHour);
                            break;
                          case AppointmentsStatusEnum.cancelado:
                            Get.toNamed(Routes.canceledSelectHour);
                            break;
                          case AppointmentsStatusEnum.aguardandoReagendamento:
                            Get.toNamed(Routes.onReappoinmentSelectHour);
                            break;
                          default:
                        }
                      },
                    );
                  }
                }
                return StandartFormartCalendarCell(day: day);
              },
            ),
            24.heightGap,
          ],
        );
      }),
    );
  }
}
