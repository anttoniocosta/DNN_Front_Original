import 'package:dnn_app_clinic/core/core.dart';
import 'package:dnn_app_clinic/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class AlreadyAppointmentedHoursPage extends StatelessWidget {
  const AlreadyAppointmentedHoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyDoctorsAppointmentsController>(
      builder: (_) {
        return AppointmentHoursPartial(
          titlePage: 'Consultas agendadas',
          contentTitle: 'Consultas agendadas no dia',
          dayTitle: 'Dia da consulta selecionada',
          daySelected: _.myAppointment!.date!.formatDateFromIso(),
          specialist: _.specialist,
          child: Column(
            children: _.myAppointment!.schedules!.map((e) {
              return AppointmentForReappointmentCard(
                centerText: _.status!.name!,
                model: e,
                hour: e.dateSchedule!.formartHourFromDateIso(),
                onCancel: () {
                  _.setSelectedAppoitment(e);
                  Get.toNamed(Routes.appointmentedConfirm);
                },
                onReappointment: () async {
                  LoadingDialog.show(Get.context!);
                  final result = await _.getReschedule(e.id!);
                  LoadingDialog.hide(Get.context!);
                  if (result) Get.toNamed(Routes.reappoinmentSelectDay);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
