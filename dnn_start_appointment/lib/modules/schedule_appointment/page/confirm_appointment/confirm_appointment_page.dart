import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:flutter/material.dart';

class ConfirmAppointmentPage extends StatelessWidget {
  const ConfirmAppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScheduleController>(builder: (_) {
      return MobileLayout(
        needCenter: false,
        needScrollView: true,
        title: _.isReadyService ? 'Pronto atendimento' : 'Agendar consulta',
        maxWidth: Responsive.maxWidth(),
        bodyChild: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              _.isReadyService
                  ? 'Confirmação para pronto atendimento'
                  : 'Confirmação de agendamento',
              style: Fonts.headlineMedium(context).copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            16.heightGap,
            Text(
              _.isReadyService
                  ? 'Confirme e clique em continuar para seguir para o pronto atendimento.'
                  : 'Ao aceitar e continuar, na finalização você receberá um e-mail. Lembre-se de estar on-line na data e hora marcada para a consulta.',
              style: Fonts.bodyLarge(context),
            ),
            32.heightGap,
            GetBuilder<ScheduleController>(
              builder: (_) {
                return ScheduleCardHour(e: _.scheduleHourSelected!);
              },
            ),
            16.heightGap,
          ],
        ),
        bottomSheet: GetBuilder<ScheduleController>(builder: (_) {
          return BottomConfirmButton(
            onTap: () {
              storage.setPaymentCicle(3);
              storage.removeIsAnotherPatient();
              storage.removeAccountForSchedule();
              storage.saveScheduleConsultId(_.scheduleHourSelected!.id!);
              //Get.toNamed(Routes.scheduleOtherPatient);
              CustomDialogs.modalBottomSheet(
                  context: Get.context!,
                  content: SizedBox(
                    height: 250,
                    child: Column(
                      children: [
                        10.heightGap,
                        Text(
                          _.isReadyService
                              ? 'Esse pronto atendimento é para você?'
                              : 'Essa consulta é para você?',
                          style: Fonts.bodyLarge(context)
                              .copyWith(fontFamily: Fonts.poppins),
                          textAlign: TextAlign.center,
                        ),
                        20.heightGap,
                        Row(
                          children: [
                            Expanded(
                              child: PrimaryButtonWidget(
                                onTap: () {
                                  storage.saveIsAnotherPatient(false);
                                  storage.removeAccountForSchedule();
                                  Get.toNamed(
                                    Routes.useTerms,
                                    arguments: false,
                                  );
                                },
                                fontSize: 16,
                                titleButtom: 'Para mim',
                              ),
                            ),
                            20.widthGap,
                            Expanded(
                              child: SecondaryButtonWidget(
                                onTap: () {
                                  storage.saveIsAnotherPatient(true);
                                  Get.toNamed(Routes.schedulePatientInfos);
                                },
                                fontSize: 16,
                                titleButtom: 'Para outra pessoa',
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ));
            },
            title: _.isReadyService
                ? 'Confirmar e continuar'
                : 'Aceitar e continuar',
          );
        }),
      );
    });
  }
}
