import 'package:dnn_app_clinic/core/clinic/controller/my_appointments_controller.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class AlreadyAppointmentedConfirmCancelPage extends StatefulWidget {
  const AlreadyAppointmentedConfirmCancelPage({super.key});

  @override
  State<AlreadyAppointmentedConfirmCancelPage> createState() =>
      _AlreadyAppointmentedConfirmCancelPageState();
}

class _AlreadyAppointmentedConfirmCancelPageState
    extends State<AlreadyAppointmentedConfirmCancelPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
            SpecialistCard(
              specialist: SpecialistResponseModel(),
              isSelected: true,
              crmNumber: _.specialist!.doctor!.crmNumber,
              specialty: _.specialist!.specialtyName,
              fullName: _.specialist!.doctor!.fullName!.capitalize,
              price: _.specialist!.price!.toString(),
              clinicName: _.specialist!.clinic!.fullName!.capitalize,
            ),
            24.heightGap,
            AppointmentBaseCard(
              hour:
                  _.selectedAppoitment!.dateSchedule!.formartHourFromDateIso(),
              centerText: _.status!.name!,
              model: _.selectedAppoitment,
            ),
            Text(
              'Diga o motivo do cancelamento',
              style: Fonts.titleLarge(context),
            ),
            10.heightGap,
            Form(
              key: formKey,
              child: StandartTextField(
                labelText: 'Razão do cancelamento',
                hintText: 'Sua motivação aqui...',
                controller: _.reasonController,
                validator: ValidatorsCustom.stringValidator,
              ),
            ),
            10.heightGap,
            Text(
              'Instruções do cancelamento',
              style: Fonts.titleLarge(context),
            ),
            16.heightGap,
            Text(
              'Você está prestes a cancelar sua consulta agendada.',
              style: Fonts.bodyLarge(context),
            ),
            Text(
              'Por favor, confirme sua decisão.',
              style: Fonts.bodyLarge(context),
            ),
            const AppointmentRichText(
                title: 'Taxa de cancelamento após 7 dias do agendamento',
                content: 'R\$ 15,00'),
            40.heightGap,
            SecondaryButtonWidget(
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  LoadingDialog.show(Get.context!);
                  final result = await _.cancelAppointment();
                  LoadingDialog.hide(Get.context!);
                  if (result) {
                    Get.offAllNamed(Routes.appointmentedConclusion);
                  }
                }
              },
              titleButtom: 'Confirmar cancelamento',
            ),
            14.heightGap,
            PrimaryButtonWidget(
              onTap: () {},
              titleButtom: 'Manter agendamento',
            ),
            16.heightGap,
          ],
        ),
      );
    });
  }
}
