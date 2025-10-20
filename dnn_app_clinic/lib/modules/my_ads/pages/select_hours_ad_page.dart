import 'package:dnn_app_clinic/core/core.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class SelectHoursAdPage extends StatefulWidget {
  const SelectHoursAdPage({super.key});

  @override
  State<SelectHoursAdPage> createState() => _SelectHoursAdPageState();
}

class _SelectHoursAdPageState extends State<SelectHoursAdPage> {
  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Meus anuncios',
      maxWidth: Responsive.maxWidth(),
      bodyChild: GetBuilder<MyAdsController>(builder: (myAds) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.heightGap,
            SpecialistCard(
              isSelected: true,
              crmNumber: myAds.selectedSpecialist!.doctor!.crmNumber!,
              specialty: myAds.selectedSpecialist!.specialtyName!,
              fullName: myAds.selectedSpecialist!.doctor!.fullName!,
              price: myAds.selectedSpecialist!.price.toString(),
              clinicName: myAds.selectedSpecialist!.clinic!.fullName!,
            ),
            15.heightGap,
            Text(
              'Selecione um ou mais horários para serem removidos da agenda.',
              style: Fonts.headlineMedium(context),
            ),
            24.heightGap,
            AppointmentRichText(
              title: 'Dia da consulta selecionada',
              content: myAds.selectedDate!.date!.formatDate(),
            ),
            24.heightGap,
            ...myAds.selectedDate!.hours!.map(
              (hour) => HourScheduledTile(
                hour: hour.hour!,
                typeScheduled: hour.typeScheduleName!,
                price: hour.price!,
                isSelected: myAds.hoursToRemove.contains(hour),
                onTap:

                    //  () {
                    //         CustomDialogs.confirmDialog(
                    //           title: 'Este horário não pode ser excluído.',
                    //           backAcion: () {},
                    //           confirmAcion: () => Get.back(),
                    //           context: context,
                    //           backVisible: false,
                    //         );
                    //       }
                    //     :

                    () => myAds.selectDay(hour),
                disabled: false,
              ),
            ),
            24.heightGap,
            PrimaryButtonWidget(
              isLoading: myAds.isLoadingDelete.value,
              onTap: myAds.hoursToRemove.isEmpty
                  ? null
                  : () async {
                      final result = await myAds.removeSchedules();
                      if (result) {
                        Get.offAllNamed(Routes.adSelectConclusion);
                      }
                    },
              titleButtom: 'Remover anuncios',
            ),
            24.heightGap,
          ],
        );
      }),
    );
  }
}
