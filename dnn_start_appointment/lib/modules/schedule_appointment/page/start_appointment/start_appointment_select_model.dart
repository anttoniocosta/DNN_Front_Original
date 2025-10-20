import 'package:dnn_app/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartAppointmentSelectModel extends StatelessWidget {
  const StartAppointmentSelectModel({super.key});

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

  _body(context) {
    return GetBuilder<ScheduleController>(builder: (_) {
      return Column(
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
                      style: Fonts.bodyLarge(context)
                          .copyWith(fontFamily: Fonts.poppins)),
                ],
              )),
          20.heightGap,
          HomeActionsListWidget(
            cardList: [
              CardTabsHome(
                title: "Pronto atendimento",
                imageSrc: MediaRes.promptService,
                isPrincipal: true,
                onTap: () async {
                  _.setIsReadyService(true);
                  _.setTypeScheduleId(1);
                  LoadingDialog.show(Get.context!);
                  await _.getFilterSpecialties();
                  await invoiceController.getInvoices();
                  await invoiceController.getInvoicesServices();
                  if (invoiceController.activeContractList.isNotEmpty) {
                    if (_.specialtyListFiltered.isNotEmpty) {
                      _.setSpecialtyId(_.specialtyListFiltered[0].id!);
                    }
                    await _.getFilterDays();
                    //PRONTO ATENDIMENTO
                    await _.getFilterHours();
                    if (_.filterHourList.isNotEmpty) {
                      _.setScheduleSelectedHour(_.filterHourList[0]);
                      storage.setPaymentCicle(3);
                      storage.removeIsAnotherPatient();
                      storage.removeAccountForSchedule();
                      storage
                          .saveScheduleConsultId(_.scheduleHourSelected!.id!);
                      storage.saveIsAnotherPatient(false);
                      storage.removeAccountForSchedule();
                      final result =
                          await startAppointmentController.verifyPermissions();
                      LoadingDialog.hide(Get.context!);
                      if (result) {
                        await _.schedule();
                        return;
                      } else {
                        Get.toNamed(Routes.paymentChoice);
                        return;
                      }
                    }
                    LoadingDialog.hide(Get.context!);
                  }
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
              CardTabsHome(
                title: "Agendar consulta",
                imageSrc: MediaRes.scheduleNewAppointment,
                isPrincipal: false,
                onTap: () {
                  _.setIsReadyService(false);
                  Get.toNamed(Routes.scheduleType);
                },
              ),
            ],
          ),
        ],
      );
    });
  }
}
