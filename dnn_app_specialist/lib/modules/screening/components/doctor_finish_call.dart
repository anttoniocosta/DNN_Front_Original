import 'package:dnn_app_specialist/core/specialist/controller/speacialist_controller.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_streamming/dnn_streamming.dart';
import 'package:flutter/material.dart';

class DoctorFinishCallWidget extends StatefulWidget {
  const DoctorFinishCallWidget({super.key});

  @override
  State<DoctorFinishCallWidget> createState() => _DoctorFinishCallWidgetState();
}

class _DoctorFinishCallWidgetState extends State<DoctorFinishCallWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Widget _divider(String text) {
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
      title: 'Finalização da consulta',
      appBarActions: const [],
      hasActions: false,
      bodyChild: GetBuilder<SpecialistController>(builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            _divider('Informações do paciênte'),
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
            _divider('Parecer médico'),
            10.heightGap,
            Text(
              'Antes de finalizar a consulta, deixe uma explicação ou comentário para o seu paciênte',
              style: Fonts.bodyLarge(context),
            ),
            20.heightGap,
            Form(
              key: formKey,
              child: StandartTextField(
                labelText: 'Parecer',
                controller: _.miniMedicalRecord,
                hintText: 'Insira o texto necessário',
                validator: ValidatorsCustom.stringValidator,
              ).paddingOnly(bottom: 6),
            ),
            30.heightGap,
            PrimaryButtonWidget(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  _.closeScheduled();
                  streammingController.disposeEngine();
                }
              },
              titleButtom: 'Finalizar consulta',
            ),
            30.heightGap,
          ],
        );
      }),
    );
  }
}
