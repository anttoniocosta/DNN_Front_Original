import 'package:dnn_app_specialist/core/specialist/controller/my_appointments_controller.dart';
import 'package:dnn_app_specialist/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';

import 'package:flutter/material.dart';

class AlreadyAppointmentedHoursPage extends StatelessWidget {
  const AlreadyAppointmentedHoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAppointmentsController>(builder: (_) {
      return AppointmentHoursPartial(
        titlePage: 'Consultas agendadas',
        contentTitle: 'Consultas agendadas no dia',
        dayTitle: 'Dia da consulta selecionada',
        daySelected: _.myAppointment!.date!.formatDateFromIso(),
        child: Column(
          children: _.myAppointment!.schedules!.map((e) {
            return AppointmentWithNoActionCard(
              centerText: 'Consulta agendada',
              model: e,
              hour: e.dateSchedule!.formartHourFromDateIso(),
            );
          }).toList(),
        ),
      );
    });
  }
}
