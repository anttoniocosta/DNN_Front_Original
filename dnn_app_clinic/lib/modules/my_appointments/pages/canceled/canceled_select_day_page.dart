import 'package:dnn_app_clinic/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class CanceledSelectDayPage extends StatelessWidget {
  const CanceledSelectDayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectDayAppointmentPartial(
      titlePage: 'Consultas canceladas',
      contentTitle: 'Selecione o dia com consultas agendadas',
      onContinue: () => Get.toNamed(Routes.canceledSelectHour),
    );
  }
}
