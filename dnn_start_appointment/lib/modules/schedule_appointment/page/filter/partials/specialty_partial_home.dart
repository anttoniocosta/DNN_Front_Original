import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:flutter/material.dart';

class SpecialtyFilterPartialHome extends StatelessWidget {
  const SpecialtyFilterPartialHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScheduleController>(
      initState: (_) async {
        Future.delayed(
          const Duration(milliseconds: 10),
          () async {
            ScheduleController scheduleController = Get.find();
            scheduleController.setIsReadyService(false);
            if (scheduleController.typeSchedules.isNotEmpty) {
              scheduleController
                  .setTypeScheduleId(scheduleController.typeSchedules[0].id!);
              await scheduleController.getFilterSpecialties();
            }
          },
        );
      },
      builder: (_) {
        return GetBuilder<StartAppointmentController>(
          builder: (startAppointment) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.heightGap,
                CustomSearchBar(
                  hintText: 'O que você está procurando?',
                  controller: _.filterSpecialist,
                  onChanged: (value) {
                    _.filterSpecialistList(value);
                  },
                ),
                20.heightGap,
                if (_.filterSpecialist.text.isNotEmpty) ...[
                  if (_.specialtyListFiltered.isNotEmpty) ...[
                    ..._.specialtyListFiltered.where((e) {
                      if (_.selectedCity == 'Todos') {
                        return true;
                      } else {
                        return e.state == _.selectedCity;
                      }
                    }).map(
                      (e) => SearchResultTile(
                        onTap: () async {
                          _.setSpecialtyId(e.id!);
                          // TODO: To improve performance, perform the check for empty hours on getFilterDays API on our backend. This is a temporary patch.
                          LoadingDialog.show(Get.context!);
                          await _.getFilterDays();
                          List<ScheduleFilterDaysResponse> newFilterDaysList =
                              [];
                          for (var event in _.filterDaysList) {
                            _.setScheduleSelectedDay(event);
                            _.setDate(event.dateSchedule!);
                            await _.getFilterHours();
                            if (_.filterHourList.isNotEmpty) {
                              newFilterDaysList.add(event);
                            }
                          }
                          _.setFilterDaysList(newFilterDaysList);
                          LoadingDialog.hide(Get.context!);
                          // PRONTO ATENDIMENTO
                          if (_.isReadyService) {
                            LoadingDialog.show(Get.context!);
                            await _.getFilterHours();
                            LoadingDialog.hide(Get.context!);
                            if (_.filterHourList.isNotEmpty) {
                              Get.toNamed(Routes.scheduleSpecialtyAble);
                            }
                          } else {
                            if (_.filterDaysList.isNotEmpty) {
                              await startAppointment.verifyPermissions();
                              Get.toNamed(Routes.scheduleSpecialtyFilter);
                            } else {
                              SnackbarCustom.snackbarError(
                                  'Não há registro para esta especialidade no momento');
                            }
                          }
                        },
                        bgColor: Get.isDarkMode
                            ? AppColors.blackDarkColor
                            : AppColors.defaultBackgroundCardColor,
                        child: Text(
                          e.name ?? '',
                          style: Fonts.bodyLarge(Get.context!).copyWith(
                            fontSize: 14,
                            fontWeight: Fonts.light,
                          ),
                        ),
                      ),
                    )
                  ] else ...[
                    Center(
                      child: Text(
                        'Sem resultados para a sua pesquisa...',
                        textAlign: TextAlign.center,
                        style: Fonts.titleLarge(context).copyWith(
                          fontFamily: Fonts.poppins,
                          fontSize: 12,
                        ),
                      ),
                    )
                  ]
                ]
              ],
            );
          },
        );
      },
    );
  }
}
