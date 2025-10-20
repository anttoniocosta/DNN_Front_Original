import 'package:dnn_app_clinic/core/core.dart';
import 'package:dnn_app_clinic/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class ReappointmentHoursPage extends StatelessWidget {
  const ReappointmentHoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyDoctorsAppointmentsController>(
      builder: (_) {
        return AppointmentHoursPartial(
          titlePage: 'Consultas agendadas',
          contentTitle: 'Selecione o horário do atendimento:',
          dayTitle: 'Dia da consulta selecionada',
          daySelected: _.rescheduleDateSelected!.date!.formatDateFromIso(),
          specialist: _.specialist,
          child: Column(
              children: _.rescheduleDateSelected!.hours!.map((e) {
            return AvaiableHourTile(
                hour: e.hour!,
                price: e.price!,
                isSelected: true,
                centerText: 'Disponível',
                onTap: () {
                  _.setRescheduleHourSelected(e);
                  Get.toNamed(Routes.reappoinmentConfirm);
                });
          }).toList()),
        );
      },
    );
  }
}
