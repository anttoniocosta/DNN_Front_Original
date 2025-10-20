import 'dart:async';

import 'package:dnn_app_specialist/core/specialist/controller/speacialist_controller.dart';
import 'package:dnn_app_specialist/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

class ReadyAppointmentList extends StatelessWidget {
  const ReadyAppointmentList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecialistController>(
      initState: (state) {
        Timer.periodic(
          const Duration(seconds: 10),
          (timer) async {
            if (Get.currentRoute != Routes.triagemQueueDoctor) {
              return timer.cancel();
            }
            state.controller!.getQueueTriagem();
          },
        );
      },
      builder: (_) {
        return MobileLayout(
          needCenter: _.isGetTriagem.value,
          needScrollView: _.isGetTriagem.value,
          title: 'Fila de triagem',
          bodyChild: _.triagemList.isEmpty
              ? TryAgainPage(
                  message: 'Sem pessoas na fila de triagem',
                  buttonTitle: 'Atualizar fila',
                  onTryAgain: () => _.getQueueTriagem())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.heightGap,
                    Flexible(
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
                              'TRIAGEM',
                              style: Fonts.displaySmall(context),
                            ),
                            10.heightGap,
                            Expanded(
                              child: ListView.builder(
                                itemCount: _.triagemList.length,
                                shrinkWrap: true,
                                itemBuilder: (__, index) {
                                  final patient = _.triagemList[index];
                                  return PatientTile(
                                    index: index + 1,
                                    name: patient.fullName!.capitalize!,
                                    document: patient.document!,
                                    photo: patient.photo,
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
                        _.setNextPatient(_.triagemList.first);
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
