import 'package:dnn_app_clinic/core/clinic/export.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class ReappointmentFinishedPage extends StatefulWidget {
  const ReappointmentFinishedPage({super.key});

  @override
  State<ReappointmentFinishedPage> createState() =>
      _ReappointmentFinishedPageState();
}

class _ReappointmentFinishedPageState extends State<ReappointmentFinishedPage> {
  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Consultas agendadas',
      bodyChild: GetBuilder<MyDoctorsAppointmentsController>(builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.heightGap,
            Text(
              'Pronto! Solicitação realizada com sucesso.',
              style: Fonts.headlineMedium(context).copyWith(fontSize: 24),
            ),
            Text(
              'Uma notificação foi encaminhada para o paciente.',
              style: Fonts.bodyLarge(context),
            ),
            10.heightGap,
            Image.asset(MediaRes.appointmentFinish, width: 200).toCenter,
            10.heightGap,
            AppointmentWithStatusCard(
              hour: _.rescheduleHourSelected!.hour!,
              centerText: 'Reagendamento',
              model: MyAppointmentsResponseModel(
                price: _.rescheduleHourSelected!.price!,
                patient: _.rescheduleModel!.patient!,
              ),
              contentText: 'Aguardando aprovação do paciente',
              titleText: 'Status do reagendamento',
            ),
            10.heightGap,
            PrimaryButtonWidget(
              titleButtom: 'Voltar para o início',
              onTap: () {
                navigationController.setIndex(NavigationTabs.home);
                Get.offNamed(Routes.basePage);
              },
            ),
            10.heightGap,
          ],
        );
      }),
    );
  }
}
