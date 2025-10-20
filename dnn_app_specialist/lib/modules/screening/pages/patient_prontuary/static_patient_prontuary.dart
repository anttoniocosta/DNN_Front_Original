import 'package:dnn_app_specialist/core/specialist/controller/speacialist_controller.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class StaticPatientProntuary extends StatelessWidget {
  const StaticPatientProntuary({super.key, this.needButtons = true});

  final bool? needButtons;

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
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Dados do paciente',
      hasActions: false,
      bodyChild: GetBuilder<SpecialistController>(builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.heightGap,
            Text(
              'Prontuário do paciente',
              style: Fonts.titleLarge(context),
            ),
            10.heightGap,
            Row(
              children: [
                PictureWidget(
                  img: _.selectedNextPatient!.photo,
                  size: const Size(60, 60),
                  radius: 5000,
                ),
                20.widthGap,
                Text(
                  _.selectedNextPatient!.fullName!.capitalize!,
                  style: Fonts.titleMedium(context),
                )
              ],
            ),
            _divider('Informações pessoais'),
            AppointmentRichText(
              title: 'Documento',
              content: _.selectedNextPatient!.document!.formatDocument(),
            ),
            AppointmentRichText(
              title: 'Data de nascimento',
              content: _.selectedNextPatient!.birthday!.formatDateFromIso(),
            ),
            AppointmentRichText(
              title: 'Idade',
              content: _.selectedNextPatient!.age != null
                  ? _.selectedNextPatient!.age.toString()
                  : 'Sem informações',
            ),
            AppointmentRichText(
              title: 'Sexo',
              content: _.selectedNextPatient!.gender!.genderRecover(),
            ),
            20.heightGap,
            _divider('Queixa principal'),
            Text(
              _.selectedNextPatient!.mainComplaint ?? 'Sem dados',
              style: Fonts.bodyLarge(context),
            ),
            _divider('Alergias'),
            Text(
              _.selectedNextPatient!.medicalHistory ?? 'Sem dados',
              style: Fonts.bodyLarge(context),
            ),
            _divider('Medicações atuais'),
            Text(
              _.selectedNextPatient!.currentMedication ?? 'Sem dados',
              style: Fonts.bodyLarge(context),
            ),
            PrimaryButtonWidget(
              isLoading: _.isStartTriagem.value,
              onTap: () {
                switch (_.screeningCicle) {
                  case ScreeningCicle.triagem:
                    _.startTriagem();
                    break;
                  case ScreeningCicle.scheduled:
                  case ScreeningCicle.ready:
                    _.startScheduled();
                    break;
                  default:
                }
              },
              titleButtom: 'Iniciar atendimento',
            ).paddingOnly(bottom: 10, top: 20),
            SecondaryButtonWidget(
              onTap: () => Get.back(),
              titleButtom: 'Cancelar atendimento',
            ),
            10.heightGap,
          ],
        );
      }),
    );
  }
}
