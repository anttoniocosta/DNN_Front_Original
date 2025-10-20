import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class PatientTile extends StatelessWidget {
  const PatientTile({
    super.key,
    required this.index,
    required this.name,
    required this.document,
    this.photo,
  });

  final int index;
  final String name;
  final String document;
  final String? photo;

  _divider(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: Get.isDarkMode
              ? AppColors.lighterGreyColor
              : AppColors.blackDarkColor,
        ),
        Text(
          text,
          style: Fonts.titleLarge(Get.context!),
        ),
        Divider(
          color: Get.isDarkMode
              ? AppColors.lighterGreyColor
              : AppColors.blackDarkColor,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _divider('Paciente $index'),
        Row(
          children: [
            PictureWidget(
              img: photo ?? MediaRes.blankImg,
              size: const Size(60, 60),
              radius: 5000,
            ),
            20.widthGap,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Fonts.titleMedium(context),
                  ),
                  AppointmentRichText(
                    title: 'Documento',
                    content: document.formatDocument(),
                  ),
                ],
              ),
            ),
            const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: 20,
            )
          ],
        ).paddingSymmetric(vertical: 10),
      ],
    );
  }
}

class PatientScheduledTile extends StatelessWidget {
  const PatientScheduledTile({
    super.key,
    required this.patient,
  });

  final QueueResponseModel patient;

  _divider(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: Get.isDarkMode
              ? AppColors.lighterGreyColor
              : AppColors.blackDarkColor,
        ),
        Text(
          text,
          style: Fonts.titleLarge(Get.context!),
        ),
        Divider(
          color: Get.isDarkMode
              ? AppColors.lighterGreyColor
              : AppColors.blackDarkColor,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _divider('Paciente ${patient.position}'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PictureWidget(
              img: patient.photo ?? MediaRes.blankImg,
              size: const Size(60, 60),
              radius: 5000,
            ),
            20.widthGap,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.fullName ?? 'Sem dados',
                    style: Fonts.titleMedium(context),
                  ),
                  AppointmentRichText(
                    title: 'Documento',
                    content: patient.document?.formatDocument() ?? 'Sem dados',
                  ),
                  // AppointmentRichText(
                  //   title: 'Data',
                  //   content:
                  //       patient.startDate?.formatDateFromIso() ?? 'Sem dados',
                  // ),
                  // AppointmentRichText(
                  //   title: 'Horário',
                  //   content: patient.startDate?.formartHourFromDateIso() ??
                  //       'Sem dados',
                  // ),
                ],
              ),
            ),
            const FaIcon(FontAwesomeIcons.chevronRight, size: 20)
          ],
        ).paddingSymmetric(vertical: 10),
      ],
    );
  }
}
