import 'package:dnn_app_specialist/core/specialist/controller/my_appointments_controller.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

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
      bodyChild: GetBuilder<MyAppointmentsController>(builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        Get.toNamed(Routes.appointmentedSelectHour);
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
