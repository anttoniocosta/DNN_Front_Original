import 'package:dnn_app_clinic/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class OnReappointmentSelectDayPage extends StatelessWidget {
  const OnReappointmentSelectDayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectDayAppointmentPartial(
      titlePage: 'Aguardando aprovação',
      contentTitle:
          'Selecione o dia que deseja visualizar os reagendamentos aguardando aprovação',
      onContinue: () => Get.toNamed(Routes.onReappoinmentSelectHour),
    );
  }
}
