import 'dart:async';

import 'package:dnn_app_specialist/core/specialist/controller/speacialist_controller.dart';
import 'package:dnn_app_specialist/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

class ScheduledAppointmentList extends StatelessWidget {
  const ScheduledAppointmentList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecialistController>(
      initState: (state) {
        Timer.periodic(
          const Duration(seconds: 10),
          (timer) async {
            if (Get.currentRoute != Routes.scheduledQueueDoctor) {
              return timer.cancel();
            }
            state.controller!.getQueues(
              state.controller!.screeningCicle == ScreeningCicle.ready,
            );
          },
        );
      },
      builder: (_) {
        return MobileLayout(
          needCenter: false,
          needScrollView: false,
          title:
              'Fila de ${_.screeningCicle == ScreeningCicle.scheduled ? 'agendamentos' : 'pronto atendimento'}',
          bodyChild: _.scheduledList.isEmpty
              ? TryAgainPage(
                  message:
                      'Sem pessoas na fila de ${_.screeningCicle == ScreeningCicle.scheduled ? 'agendados' : 'pronto atendimento'}',
                  buttonTitle: 'Atualizar fila',
                  onTryAgain: () =>
                      _.getQueues(_.screeningCicle == ScreeningCicle.ready))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.heightGap,
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          boxShadow: highElevation,
                          color: Theme.of(context).colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(radiusMedium),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fila de pacientes no plantão',
                              style: Fonts.titleLarge(context),
                            ),
                            Text(
                              _.screeningCicle == ScreeningCicle.scheduled
                                  ? 'AGENDAMENTOS'
                                  : 'Pronto Atendimento'.toUpperCase(),
                              style: Fonts.displaySmall(context),
                            ),
                            10.heightGap,
                            Expanded(
                              child: ListView.builder(
                                itemCount: _.scheduledList.length,
                                shrinkWrap: true,
                                itemBuilder: (__, index) {
                                  final patient = _.scheduledList[index];
                                  return PatientScheduledTile(
                                    patient: patient,
                                  );
                                },
                              ),
                            ),
                          ],
                        ).paddingSymmetric(vertical: 12),
                      ),
                    ),
                    20.heightGap,
                    PrimaryButtonWidget(
                      onTap: () {
                        _.setNextPatient(_.scheduledList.first);
                        Get.toNamed(Routes.screenProntuaryClient);
                      },
                      titleButtom: 'Atender próximo paciente',
                    ),
                    10.heightGap,
                  ],
                ),
        );
      },
    );
  }
}
