import 'package:dnn_app_clinic/core/clinic/export.dart';
import 'package:dnn_app_clinic/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class PublishAgendaFinishedPage extends StatelessWidget {
  const PublishAgendaFinishedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Divulgar agenda',
      maxWidth: Responsive.maxWidth(),
      bodyChild: GetBuilder<PublishAgendaController>(builder: (pbAgenda) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.heightGap,
            Text(
              'Divulgação da agenda realizada com sucesso!',
              style: Fonts.headlineMedium(context).copyWith(fontSize: 24),
              textAlign: TextAlign.center,
            ).paddingSymmetric(horizontal: 20),
            24.heightGap,
            Image.asset(
              MediaRes.doctorAgenda,
              width: 200,
            ).toCenter,
            24.heightGap,
            if (pbAgenda.isReadyService)
              PlantonistCard(
                isSelected: true,
                onTap: null,
                specialty: pbAgenda.selectedSpecialist!.specialtyName!,
                price: pbAgenda.selectedSpecialist!.price.toString(),
              )
            else
              SpecialistCard(
                specialist: SpecialistResponseModel(),
                isSelected: true,
                crmNumber: pbAgenda.selectedSpecialist!.doctor!.crmNumber,
                specialty: pbAgenda.selectedSpecialist!.specialtyName,
                fullName: pbAgenda.selectedSpecialist!.doctor!.fullName,
                price: pbAgenda.selectedSpecialist!.price.toString(),
                clinicName: pbAgenda.selectedSpecialist!.clinic!.fullName,
              ),
            20.heightGap,
            if (!pbAgenda.isReadyService)
              AppointmentRichText(
                title: 'Dias escolhidos',
                content: pbAgenda.selectedDays
                    .map((e) => e.day.formatDateShort())
                    .join(' | '),
              ),
            20.heightGap,
            if (pbAgenda.isReadyService) ...[
              Text(
                'Divulgação do pronto atendimento feita com sucesso, assim que houver paciêntes na emergência, estarão na fila de atendimento dos especialista da sua clínica.',
                style: Fonts.bodyLarge(context),
              ),
            ] else ...[
              Text(
                'Horas criadas',
                style: Fonts.titleLarge(context),
              ),
              Text(
                'As horas serão replicadas nos dias selecionados',
                style: Fonts.bodyMedium(context),
              ),
              ...pbAgenda.publisListHours.map(
                (hour) => HourCreatedDemonstration(
                  hour: hour.hour!,
                  scheduleType:
                      pbAgenda.getScheduleTypeName(hour.typeScheduleId!),
                  price: hour.price!,
                ),
              ),
            ],
            20.heightGap,
            PrimaryButtonWidget(
              titleButtom: 'Ir para o início',
              onTap: () {
                navigationController.setIndex(NavigationTabs.home);
                Get.offNamed(Routes.basePage);
                Future.delayed(const Duration(milliseconds: 100), () {
                  pbAgenda.clear();
                  pbAgenda.clearHour();
                });
              },
            ),
            20.heightGap,
          ],
        );
      }),
    );
  }
}
