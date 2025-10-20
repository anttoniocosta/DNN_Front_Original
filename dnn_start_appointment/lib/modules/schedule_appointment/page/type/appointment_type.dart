import 'package:dnn_app/modules/base/export.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:flutter/material.dart';

class AppointmentTypePage extends StatelessWidget {
  const AppointmentTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      needBounce: false,
      needMaxWidth: false,
      needAppBar: false,
      needPadding: false,
      drawer: const DrawerCustom(navbarItems: NaviItems()),
      title: 'Iniciar consulta',
      maxWidth: Responsive.maxWidth(),
      bodyChild: _body(context),
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
  }
}

_body(context) {
  return GetBuilder<ScheduleController>(builder: (_) {
    if (_.typeSchedules.isEmpty) {
      return TryAgainPage(
        message: 'Não foi possível recuperar os dados',
        onTryAgain: () => _.getTypeSchedule(),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HomeHeaderWidget(),
        20.heightGap,
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Iniciar consulta",
                style: Fonts.titleLarge(context),
              ),
              5.heightGap,
              Text("Escolha a melhor opção para você!",
                  style: Fonts.bodyLarge(context)),
            ],
          ),
        ),
        20.heightGap,
        HomeActionsListWidget(cardList: [
          ..._.typeSchedules.map(
            (e) => CardTabsHome(
              title: 'Consulta ${e.name!}',
              imageSrc: _.getCardIcon(e.id!),
              isPrincipal: false,
              onTap: () async {
                _.setTypeScheduleId(e.id!);
                LoadingDialog.show(Get.context!);
                await _.getFilterSpecialties();
                LoadingDialog.hide(Get.context!);
                if (_.specialtyList.isNotEmpty) {
                  Get.toNamed(Routes.scheduleGeneralFilters);
                } else {
                  SnackbarCustom.snackbarError(
                    'Não há especialidades no momento para o tipo de atendimento selecionado',
                  );
                }
              },
            ),
          )
        ]),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     ..._.typeSchedules.map(
        //       (e) => SizedBox(
        //         height: 113,
        //         width: 108,
        //         child: CardAppointmentType(
        //           title: e.name!,
        //           backgroundColor: Get.isDarkMode
        //               ? AppColors.midBlackColor
        //               : AppColors.whiteColor,
        //           icon: _.getCardIcon(e.id!),
        //           onTap: () async {
        //             _.setTypeScheduleId(e.id!);
        //             LoadingDialog.show(Get.context!);
        //             await _.getFilterSpecialties();
        //             LoadingDialog.hide(Get.context!);
        //             if (_.specialtyList.isNotEmpty) {
        //               Get.toNamed(Routes.scheduleGeneralFilters);
        //             } else {
        //               SnackbarCustom.snackbarError(
        //                 'Não há especialidades no momento para o tipo de atendimento selecionado',
        //               );
        //             }
        //           },
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  });
}
