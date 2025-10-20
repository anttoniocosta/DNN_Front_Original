import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:flutter/material.dart';

class SpecialtyAvaiableHoursPage extends StatelessWidget {
  const SpecialtyAvaiableHoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartAppointmentController>(
      builder: (startAppointment) {
        return GetBuilder<ScheduleController>(
          builder: (_) {
            return MobileLayout(
              needCenter: false,
              needScrollView: true,
              title: _.isReadyService
                  ? "Comprar consulta"
                  : startAppointment.hasPermission == true
                      ? 'Agendar consulta'
                      : "Comprar consulta",
              maxWidth: Responsive.maxWidth(),
              bodyChild: GetBuilder<ScheduleController>(
                builder: (_) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      14.heightGap,
                      Text(
                        _.isReadyService
                            ? 'Selecione o seu pronto atendimento'
                            : 'Selecione um especialista para realizar o seu agendamento:',
                        style: TextStyle(
                            fontSize: Fonts.titleMd,
                            fontWeight: FontWeight.w700),
                      ),
                      10.heightGap,
                      if (_.isReadyService)
                        Text(
                            'Confirme e clique no pronto atendimento para continuar.',
                            style: TextStyle(
                                fontSize: Fonts.title,
                                fontWeight: FontWeight.normal)),
                      16.heightGap,
                      if (!_.isReadyService)
                        AppointmentRichText(
                          title: 'Dia escolhido',
                          content: _.date.formatDateFromIso(),
                        ),
                      GetBuilder<ScheduleController>(builder: (_) {
                        if (_.filterHourList.isNotEmpty) {
                          final priceList =
                              _.filterDaysList.map((e) => e.price).toList();
                          priceList.sort((a, b) => a!.compareTo(b!));

                          return Column(
                            children: _.filterHourList.map((e) {
                              return GetBuilder<MyAppointmentsController>(
                                  builder: (myApp) {
                                return ScheduleCardHour(
                                  e: e,
                                  hasPermission: startAppointment.hasPermission,
                                  onTap: () {
                                    _.setScheduleSelectedHour(e);
                                    Get.toNamed(Routes.scheduleConfirm);
                                  },
                                );
                              });
                            }).toList(),
                          ).paddingOnly(top: 20);
                        } else {
                          return Text(
                            _.isReadyService
                                ? 'Sem pronto atendimento disponível no momento,'
                                : 'Sem horários disponíveis, volte e selecione outro dia...',
                            style: Fonts.titleLarge(context),
                          ).paddingOnly(top: 20);
                        }
                      }),
                      60.heightGap,
                    ],
                  );
                },
              ),
              bottomSheet: CustomBottomNavigation(
                navItens: [
                  const CustomBottomItem(
                    isBackPage: true,
                    icon: MediaRes.stetoscpIcon,
                    index: NavigationTabs.myAppointmentsLogged,
                  ),
                  10.heightGap,
                  const CustomBottomItem(
                    isBackPage: true,
                    icon: MediaRes.homeIcon,
                    index: NavigationTabs.homeLogged,
                  ),
                  10.heightGap,
                  const CustomBottomItem(
                    isBackPage: true,
                    icon: MediaRes.malletIcon,
                    index: NavigationTabs.myPlansLogged,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class ScheduleCardHour extends StatelessWidget {
  const ScheduleCardHour(
      {super.key, required this.e, this.onTap, this.hasPermission});

  final ScheduleFilterHourResponse e;
  final VoidCallback? onTap;
  final bool? hasPermission;

  String returnHour(String e) {
    final hour = e.split('T').last.split(':');
    hour.removeLast();
    return hour.join(':');
  }

  Color? isAcceptText() {
    return e.isAcceptsDnnPlan! ? AppColors.whiteColor : null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: double.infinity,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: e.isAcceptsDnnPlan!
                  ? AppColors.blueColor
                  : AppColors.greyColorCard,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.whiteColor,
                                  image: DecorationImage(
                                    image:
                                        Image.asset(MediaRes.doctorIcon).image,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                              10.widthGap,
                              SizedBox(
                                child: SpecialistHeaderInfos(
                                  isSelected: false,
                                  crm: e.crmNumber ?? '',
                                  specialty: e.specialtyName ?? '',
                                  name: e.specialistName?.capitalize ?? '',
                                  color: isAcceptText(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      e.isAcceptsDnnPlan!
                          ? SvgPicture.asset(
                              MediaRes.horizontalBrancoAzulEscuro,
                              width: 96,
                              height: 32,
                            )
                          : SvgPicture.asset(
                              MediaRes.horizontalAzul,
                              width: 96,
                              height: 32,
                            )
                    ],
                  ),
                ),
                AppointmentDivider(isSelected: e.isAcceptsDnnPlan),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AppointmentRichText(
                        title: 'Tipo de consulta',
                        content: e.typeScheduleName!,
                        color: isAcceptText(),
                      ),
                    ),
                    if (hasPermission != true)
                      Container(
                        width: 1,
                        height: 15,
                        color: e.isAcceptsDnnPlan!
                            ? AppColors.whiteColor
                            : AppColors.blackDarkColor,
                      ),
                    if (hasPermission != true) 10.widthGap,
                    if (hasPermission != true)
                      Expanded(
                        child: AppointmentRichText(
                          title: 'Valor da Consulta',
                          content: e.price!.formatReal(),
                          color: isAcceptText(),
                        ),
                      ),
                  ],
                ),
                if (e.dateSchedule != null) 10.heightGap,
                if (e.dateSchedule != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AppointmentRichText(
                          title: 'Hora',
                          content: returnHour(e.dateSchedule!),
                          color: isAcceptText(),
                        ),
                      )
                    ],
                  ),
                10.heightGap,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (onTap != null)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: e.isAcceptsDnnPlan!
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: onTap,
                        child: Text(
                          'Comprar Consulta',
                          style: Fonts.titleMedium(context).copyWith(
                            fontWeight: FontWeight.normal,
                            color: e.isAcceptsDnnPlan!
                                ? AppColors.blackDarkColor
                                : AppColors.whiteColor,
                          ),
                        ),
                      ),
                  ],
                ),
                // if (e.typeScheduleName!.toLowerCase() == 'presencial') ...[
                //   AppointmentDivider(isSelected: e.isAcceptsDnnPlan),
                //   ClinicAddressInfosInline(
                //     needSeeMap: false,
                //     isSelected: false,
                //     street: e.clinicAddress!,
                //     neighborhood: e.clinicNeighborhood!,
                //     city: e.clinicCity!,
                //     state: e.clinicState!,
                //     zipCode: e.clinicZipcode!,
                //     number: e.clinicNumber!,
                //     color: isAcceptText(),
                //   ),
                // ],
                // 5.heightGap,
              ],
            ),
          ),
        ),
        // Visibility(
        //   visible: e.isAcceptsDnnPlan!,
        //   // visible: false,
        //   child: Positioned(
        //     top: -10,
        //     right: 10,
        //     child: Container(
        //       decoration: const BoxDecoration(color: AppColors.whiteColor),
        //       padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        //       child: Text(
        //         'Incluso no plano',
        //         style: Fonts.titleSmall(context),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    ).paddingOnly(bottom: 20);
  }
}
