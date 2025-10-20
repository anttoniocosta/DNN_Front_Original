import 'package:dnn_app_clinic/core/clinic/export.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class ReappointmentConfirmPage extends StatelessWidget {
  const ReappointmentConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Consultas agendadas',
      bodyChild: GetBuilder<MyDoctorsAppointmentsController>(
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.heightGap,
              SpecialistCard(
                isSelected: true,
                crmNumber: _.rescheduleModel!.doctor!.crm!,
                specialty: _.specialist!.specialtyName!,
                fullName: _.rescheduleModel!.doctor!.name!.capitalize!,
                price: _.rescheduleModel!.price!.toString(),
                clinicName: _.rescheduleModel!.clinic!.name!.capitalize!,
              ),
              24.heightGap,
              AppointmentBaseCard(
                hour: _.rescheduleModel!.currentDate!.formartHourFromDateIso(),
                centerText: 'Consulta agendada',
                model: MyAppointmentsResponseModel(
                  price: _.rescheduleHourSelected!.price!,
                  patient: _.rescheduleModel!.patient!,
                ),
              ),
              Text(
                'Instruções do reagendamento',
                style: Fonts.titleLarge(context),
              ),
              16.heightGap,
              Text(
                'Você está prestes a reagendar sua consulta.',
                style: Fonts.bodyLarge(context),
              ),
              16.heightGap,
              const AppointmentRichText(
                title:
                    'O paciente precisará aprovar o reagendamento, caso ele não aceite será realizado o cancelamento dessa consulta e uma taxa de cancelamento será aplicada de',
                content: 'R\$ 15,00',
              ),
              16.heightGap,
              Text(
                'Por favor, confirme sua decisão.',
                style: Fonts.bodyLarge(context),
              ),
              40.heightGap,
              SecondaryButtonWidget(
                onTap: () async {
                  LoadingDialog.show(Get.context!);
                  final result = await _.putReschedule(
                    ReschedulePutModel(
                      scheduleConsultationCurrentId:
                          _.rescheduleModel!.scheduleConsultationId!,
                      scheduleConsultationNewId:
                          _.rescheduleHourSelected!.scheduleConsultationNewId!,
                    ),
                  );
                  LoadingDialog.hide(Get.context!);
                  if (result) Get.offAllNamed(Routes.reappoinmentConclusion);
                },
                titleButtom: 'Confirmar reagendamento',
              ),
              14.heightGap,
              PrimaryButtonWidget(
                onTap: () => Get.back(),
                titleButtom: 'Manter agendamento',
              ),
              16.heightGap,
            ],
          );
        },
      ),
    );
  }
}
