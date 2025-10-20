import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:flutter/material.dart';

class OtherPatientSelectPage extends StatelessWidget {
  const OtherPatientSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScheduleController>(builder: (_) {
      return MobileLayout(
        needCenter: true,
        needScrollView: true,
        title: _.isReadyService ? 'Pronto atendimento' : 'Agendar consulta',
        maxWidth: Responsive.maxWidth(),
        bodyChild: Column(
          children: [
            Text(
              _.isReadyService
                  ? 'Esse pronto atendimento é para você?'
                  : 'Essa consulta é para você?',
              style: Fonts.titleLarge(context),
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
                      Get.toNamed(Routes.useTerms);
                    },
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
                    titleButtom: 'Para outra pessoa',
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
