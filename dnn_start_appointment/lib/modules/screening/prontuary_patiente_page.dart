import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:flutter/material.dart';

class PatientProntuaryPage extends StatefulWidget {
  const PatientProntuaryPage({super.key});

  @override
  State<PatientProntuaryPage> createState() => _PatientProntuaryPageState();
}

class _PatientProntuaryPageState extends State<PatientProntuaryPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  setLoading(bool val) => setState(() => isLoading = val);

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Dados do paciente',
      hasActions: false,
      bodyChild: GetBuilder<MyAppointmentsController>(
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'O que você está sentindo?',
                style: Fonts.titleLarge(context),
              ),
              10.heightGap,
              Row(
                children: [
                  PictureWidget(
                    img: ValueNotifier<String>(
                        _.selectedAppoitment!.patient!.photo ??
                            MediaRes.blankImg),
                    size: const Size(60, 60),
                    radius: 5000,
                  ),
                  20.widthGap,
                  Text(
                    _.selectedAppoitment!.patient!.name!.capitalize!,
                    style: Fonts.titleMedium(context),
                  )
                ],
              ),
              Divider(
                color: Get.isDarkMode
                    ? AppColors.lighterGreyColor
                    : AppColors.blackDarkColor,
              ),
              Text(
                'Informações pessoais',
                style: Fonts.titleLarge(context),
              ),
              Divider(
                color: Get.isDarkMode
                    ? AppColors.lighterGreyColor
                    : AppColors.blackDarkColor,
              ),
              AppointmentRichText(
                title: 'Documento',
                content:
                    _.selectedAppoitment!.patient!.document!.formatDocument(),
              ),
              AppointmentRichText(
                title: 'Data de nascimento',
                content: _.selectedAppoitment!.patient!.birthday!
                    .formatDateFromIso(),
              ),
              AppointmentRichText(
                title: 'Idade',
                content: _.selectedAppoitment!.patient!.age!.toString(),
              ),
              AppointmentRichText(
                title: 'Sexo',
                content: _.selectedAppoitment!.patient!.gender!,
              ),
              20.heightGap,
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      StandartTextField(
                        labelText: 'Queixa principal',
                        controller: _.plaintController,
                        hintText: 'Descreva o que está sentindo.',
                        validator: ValidatorsCustom.stringValidator,
                      ).paddingOnly(bottom: 6),
                      StandartTextField(
                        labelText: 'Alergias',
                        controller: _.historyController,
                        hintText: 'Descreva se possui uma ou mais alergias.',
                        validator: ValidatorsCustom.stringValidator,
                      ).paddingOnly(bottom: 6),
                      StandartTextField(
                        labelText: 'Medicações atuais',
                        controller: _.mediciansController,
                        hintText:
                            'Descreva se está usando uma ou mais medicações.',
                        validator: ValidatorsCustom.stringValidator,
                      ).paddingOnly(bottom: 20),
                    ],
                  )),
              PrimaryButtonWidget(
                isLoading: isLoading,
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    setLoading(true);
                    switch (_.streammingType) {
                      case StreammingTypeEnum.triagem:
                        final result = await _.startTriagemQueue();
                        if (result) {
                          final resultt = await _.getTriagemQueuePosition();
                          setLoading(false);
                          if (resultt) {
                            Get.toNamed(Routes.screenTriagemQueue);
                          } else {
                            SnackbarCustom.snackbarError(
                              'Não possível iniciar seu atendimento',
                            );
                          }
                        }
                        break;
                      case StreammingTypeEnum.standard:
                        await _.startStandardQueue();
                        final result = await _.getStandardQueuePosition();
                        setLoading(false);
                        if (result) {
                          Get.offAllNamed(Routes.screenTriagemQueue);
                        } else {
                          SnackbarCustom.snackbarError(
                            'Não possível iniciar seu atendimento',
                          );
                        }
                        break;
                      default:
                        SnackbarCustom.snackbarError(
                          'Não possível iniciar seu atendimento, tente novamente mais tarde',
                        );
                        break;
                    }
                  }
                },
                titleButtom: _.streammingType == StreammingTypeEnum.triagem
                    ? 'Iniciar triagem'
                    : 'Iniciar atendimento',
              ).paddingOnly(bottom: 14),
              SecondaryButtonWidget(
                onTap: () {
                  navigationController.setIndex(NavigationTabs.home);
                  Get.offAllNamed(Routes.basePage);
                },
                titleButtom: 'Voltar',
              ),
              10.heightGap,
            ],
          );
        },
      ),
    );
  }
}
