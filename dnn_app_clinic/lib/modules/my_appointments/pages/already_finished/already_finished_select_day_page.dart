import 'package:dnn_app_clinic/core/clinic/controller/my_appointments_controller.dart';
import 'package:dnn_app_clinic/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class AlreadyFinishedSelectDayPage extends StatelessWidget {
  const AlreadyFinishedSelectDayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyDoctorsAppointmentsController>(
      builder: (_) {
        return SelectDayAppointmentPartial(
          titlePage: 'Consultas ${_.status!.name!.toLowerCase()}',
          contentTitle:
              'Selecione o dia da consulta ${_.status!.name!.toLowerCase()}',
          onContinue: () => Get.toNamed(Routes.finishedSelectHour),
        );
      },
    );
  }
}
