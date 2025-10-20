import 'package:dnn_app_specialist/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

class AlreadyAppointmentedSelectDayPage extends StatelessWidget {
  const AlreadyAppointmentedSelectDayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectDayAppointmentPartial(
      titlePage: 'Consultas agendadas',
      contentTitle: 'Selecione o dia para agendamento:',
      onContinue: () => Get.toNamed(Routes.appointmentedSelectHour),
    );
  }
}
