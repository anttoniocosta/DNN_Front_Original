import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppointmentSucessPage extends StatefulWidget {
  const AppointmentSucessPage({super.key});

  @override
  State<AppointmentSucessPage> createState() => _AppointmentSucessPageState();
}

class _AppointmentSucessPageState extends State<AppointmentSucessPage> {
  String returnHour(String e) {
    final hour = e.split('T').last.split(':');
    hour.removeLast();
    return hour.join(':');
  }

  MyAppointmentsController controller = Get.find<MyAppointmentsController>();
  ScheduleController controller2 = Get.find<ScheduleController>();

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    if (controller2.isReadyService) {
      await controller.getConsultBought();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (val) {
        navigationController.setIndex(NavigationTabs.home);
        Get.offAllNamed(Routes.basePage);
      },
      child: GetBuilder<ScheduleController>(builder: (_) {
        return MobileLayout(
          needCenter: false,
          needScrollView: true,
          title: _.isReadyService ? "Pronto atendimento" : 'Agendar consulta',
          hasLeading: true,
          appBarLeading: const SizedBox(),
          maxWidth: Responsive.maxWidth(),
          bodyChild: GetBuilder<ScheduleController>(builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                24.heightGap,
                Text(
                  'Consulta agendada com sucesso',
                  style: Fonts.headlineMedium(context),
                ).toCenter,
                Image.asset(
                  MediaRes.scheduleAppointmentSucess,
                  width: 210,
                ).toCenter,
                SpecialistHeaderInfos(
                  isSelected: false,
                  crm: _.scheduleHourSelected!.crmNumber ?? '',
                  specialty: _.scheduleHourSelected!.specialtyName ?? '',
                  name:
                      _.scheduleHourSelected!.specialistName!.capitalize ?? '',
                ).paddingSymmetric(horizontal: 16),
                const AppointmentDivider(isSelected: false)
                    .paddingSymmetric(horizontal: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!_.scheduleHourSelected!.isAcceptsDnnPlan!)
                      Text(
                        _.scheduleHourSelected!.clinicName!.capitalize!,
                        style: Fonts.titleLarge(context).copyWith(),
                      ),
                    Row(
                      children: [
                        const CardIconWidget(
                          cardColor: AppColors.blueColor,
                          radius: 10,
                          icon: FontAwesomeIcons.laptopMedical,
                          iconColor: AppColors.whiteColor,
                        ),
                        22.widthGap,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_.scheduleHourSelected!.isAcceptsDnnPlan!)
                              Text(
                                'DOUTOR NA NET',
                                style: Fonts.titleLarge(context).copyWith(),
                              ),
                            if (!_.isReadyService)
                              AppointmentRichText(
                                title: 'Data',
                                content: _.scheduleHourSelected!.dateSchedule!
                                    .formatDateFromIso(),
                              ),
                            if (!_.isReadyService)
                              AppointmentRichText(
                                title: 'Hora',
                                content: returnHour(
                                    _.scheduleHourSelected!.dateSchedule!),
                              ),
                            if (!_.scheduleHourSelected!.isAcceptsDnnPlan!)
                              AppointmentRichText(
                                title: 'Valor da Consulta',
                                content:
                                    _.scheduleHourSelected!.price!.formatReal(),
                              ),
                            AppointmentRichText(
                              title: 'Tipo de consulta',
                              content:
                                  _.scheduleHourSelected!.typeScheduleName!,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ).paddingSymmetric(vertical: 10, horizontal: 16),
                const AppointmentDivider(isSelected: false)
                    .paddingSymmetric(horizontal: 16),
                ClinicAddressInfos(
                  needSeeMap: false,
                  isSelected: false,
                  street: _.scheduleHourSelected!.clinicAddress!,
                  neighborhood: _.scheduleHourSelected!.clinicNeighborhood!,
                  city: _.scheduleHourSelected!.clinicCity!,
                  state: _.scheduleHourSelected!.clinicState!,
                  zipCode: _.scheduleHourSelected!.clinicZipcode!,
                  number: _.scheduleHourSelected!.clinicNumber!,
                ).paddingSymmetric(horizontal: 16),
                20.heightGap,
                GetBuilder<ScheduleController>(builder: (schedule) {
                  return GetBuilder<MyAppointmentsController>(builder: (_) {
                    return Visibility(
                      visible: schedule.isReadyService &&
                          (_.consultBought != null &&
                              _.consultBought!.isPayment!),
                      child: SecondaryButtonWidget(
                        titleButtom: schedule.isReadyService
                            ? "Prosseguir para o pronto atendimento"
                            : 'Prosseguir para a consulta',
                        onTap: () async {
                          try {
                            _.clearController();

                            if (_.consultBought != null) {
                              _.setAppointment(_.consultBought!);
                              if (_.consultBought!.isRapidoc! &&
                                  _.consultBought!.rapidocUrl != null) {
                                Get.toNamed(Routes.serviceCall,
                                    arguments: _.consultBought!.rapidocUrl);
                              } else {
                                if (_.consultBought!.isScreening == true) {
                                  _.setStreammingType(
                                      StreammingTypeEnum.triagem);
                                } else {
                                  _.setStreammingType(
                                      StreammingTypeEnum.standard);
                                }
                                _.setController();
                                Get.offAllNamed(Routes.screenProntuaryClient);
                              }
                            } else {
                              SnackbarCustom.snackbarError(
                                'Não foi possível continuar, volte ao inicio e tente novamente',
                              );
                            }
                          } catch (e) {
                            debugPrint(e.toString());
                          }
                        },
                      ).paddingOnly(top: 20),
                    );
                  });
                }),
                10.heightGap,
                PrimaryButtonWidget(
                  onTap: () {
                    navigationController.setIndex(NavigationTabs.home);
                    Get.offAllNamed(Routes.basePage);
                  },
                  titleButtom: 'Voltar ao início',
                ),
                20.heightGap,
              ],
            );
          }),
        );
      }),
    );
  }
}
