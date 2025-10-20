import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:flutter/material.dart';

class CancelAppointmentPage extends StatefulWidget {
  const CancelAppointmentPage({super.key});

  @override
  State<CancelAppointmentPage> createState() => _CancelAppointmentPageState();
}

class _CancelAppointmentPageState extends State<CancelAppointmentPage> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Minhas consultas',
      maxWidth: Responsive.maxWidth(),
      bodyChild: GetBuilder<MyAppointmentsController>(builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            14.heightGap,
            MyAppointmentCard(
              model: _.selectedAppoitment!,
              needBottomButtons: false,
            ),
            16.heightGap,
            Text(
              'Instruções do cancelamento',
              style: Fonts.headlineMedium(context).copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            16.heightGap,
            Text(
              'Você está prestes a cancelar sua consulta agendada na ${_.selectedAppoitment!.clinic!.name!.capitalize}.',
              style: Fonts.bodyLarge(context),
            ),
            16.heightGap,
            Text(
              'Por favor, confirme sua decisão.',
              style: Fonts.bodyLarge(context),
            ),
            const AppointmentRichText(
              title: 'Taxa de cancelamento após 7 dias do agendamento',
              content: 'R\$ 15,00',
            ),
            6.heightGap,
            const Divider(),
            6.heightGap,
            Text(
              'Razão do cancelamento',
              style: Fonts.headlineMedium(context).copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Nos diga a motivação para não seguir com a sua consulta e podermos lhe ajudar.',
              style: Fonts.bodyLarge(context),
            ),
            16.heightGap,
            Form(
              key: key,
              child: StandartTextField(
                labelText: 'Razão do cancelamento',
                hintText: 'Sua motivação aqui...',
                controller: _.reasonController,
                validator: ValidatorsCustom.stringValidator,
              ),
            ),
            16.heightGap,
            SecondaryButtonWidget(
              onTap: () {
                if (key.currentState!.validate()) {
                  Get.toNamed(Routes.myAppointmentsCancelConfirm);
                }
              },
              titleButtom: 'Cancelar consulta',
            ),
            10.heightGap,
            PrimaryButtonWidget(
              onTap: () => Get.back(),
              titleButtom: 'Manter consulta',
            ),
            16.heightGap,
          ],
        );
      }),
    );
  }
}
