import 'package:dnn_app_clinic/core/clinic/export.dart';
import 'package:dnn_app_clinic/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class AlreadyFinishedHoursPage extends StatelessWidget {
  const AlreadyFinishedHoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyDoctorsAppointmentsController>(builder: (_) {
      return AppointmentHoursPartial(
        titlePage: 'Consultas ${_.status!.name!.toLowerCase()}',
        contentTitle: 'Consultas ${_.status!.name!.toLowerCase()} no dia',
        dayTitle: 'Dia da consulta selecionada',
        daySelected: _.myAppointment!.date!.formatDateFromIso(),
        specialist: _.specialist,
        child: Column(
          children: _.myAppointment!.schedules!
              .map((e) => AppointmentBaseCard(
                    hour: e.dateFinished == null
                        ? e.dateSchedule!.formartHourFromDateIso()
                        : e.dateFinished!.formartHourFromDateIso(),
                    centerText: _.status!.name ?? '',
                    model: e,
                  ))
              .toList(),
        ),
      );
    });
  }
}
