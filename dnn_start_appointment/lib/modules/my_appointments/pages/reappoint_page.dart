import 'package:flutter/material.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:get/get.dart';

class ReAppointmentPage extends StatefulWidget {
  const ReAppointmentPage({super.key});

  @override
  State<ReAppointmentPage> createState() => _ReAppointmentPageState();
}

class _ReAppointmentPageState extends State<ReAppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Minhas consultas',
      maxWidth: Responsive.maxWidth(),
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          24.heightGap,
          // MyAppointmentCard(
          //   clinicModel: ClinicViewModel.test(),
          //   specialist: SpecialistResponseModel(),
          //   onReappoint: () {},
          //   onCancel: () {},
          //   needBottomButtons: false,
          // ),
          16.heightGap,
          Text(
            'Instruções do reagendamento',
            style: Fonts.headlineMedium(context).copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          16.heightGap,
          Text(
            'A transferência somente poderá ser realizada na agenda do mesmo médico e clínica.',
            style: Fonts.bodyLarge(context),
          ),
          16.heightGap,
          Text.rich(TextSpan(children: [
            TextSpan(
              text: 'Taxa de transferência após 7 dias: ',
              style: Fonts.bodyLarge(context),
            ),
            TextSpan(
              text: 'R\$ 10,00',
              style: Fonts.titleSmall(context),
            )
          ])),
          16.heightGap,
          SecondaryButtonWidget(
            onTap: () => Get.to(() => const ConfirmReappointmentPage()),
            titleButtom: 'Reagendar consulta',
          ),
          10.heightGap,
          PrimaryButtonWidget(
            onTap: () {},
            titleButtom: 'Manter agendamento',
          ),
          16.heightGap,
        ],
      ),
    );
  }
}
