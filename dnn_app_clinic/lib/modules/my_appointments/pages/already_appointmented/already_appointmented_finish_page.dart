import 'package:dnn_app_clinic/core/clinic/export.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class AlreadyAppointmentedFinishedPage extends StatefulWidget {
  const AlreadyAppointmentedFinishedPage({super.key});

  @override
  State<AlreadyAppointmentedFinishedPage> createState() =>
      _AlreadyAppointmentedFinishedPageState();
}

class _AlreadyAppointmentedFinishedPageState
    extends State<AlreadyAppointmentedFinishedPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyDoctorsAppointmentsController>(builder: (_) {
      return MobileLayout(
        needCenter: false,
        needScrollView: true,
        title: 'Consultas agendadas',
        bodyChild: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.heightGap,
            Text(
              'Cancelamento realizado com sucesso.',
              style: Fonts.headlineMedium(context).copyWith(fontSize: 24),
            ),
            Text(
              'Uma notificação foi encaminhada para o paciente.',
              style: Fonts.bodyLarge(context),
            ),
            10.heightGap,
            Image.asset(MediaRes.appointmentFinish, width: 200).toCenter,
            10.heightGap,
            AppointmentBaseCard(
              hour:
                  _.selectedAppoitment!.dateSchedule!.formartHourFromDateIso(),
              centerText: 'Consulta agendada',
              model: _.selectedAppoitment,
            ),
            10.heightGap,
            PrimaryButtonWidget(
              titleButtom: 'Voltar para o início',
              onTap: () {
                navigationController.setIndex(NavigationTabs.home);
                Get.offAllNamed(Routes.basePage);
              },
            ),
            10.heightGap,
          ],
        ),
      );
    });
  }
}
