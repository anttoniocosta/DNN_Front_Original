import 'dart:developer';

import 'package:dnn_app/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

class UseTermsPage extends StatelessWidget {
  final bool isDrawer;
  const UseTermsPage({
    super.key,
    this.isDrawer = false,
  });

  Future<void> onContinue(ScheduleController _) async {
    if (await storage.getPaymentCicle() == 3) {
      log(storage.getPaymentCicle().toString());
      if (_.scheduleHourSelected!.isAcceptsDnnPlan!) {
        final result = await startAppointmentController.verifyPermissions();
        if (result) {
          await _.schedule();
        } else {
          Get.toNamed(Routes.paymentChoice);
        }
      } else {
        Get.toNamed(Routes.paymentChoice);
      }
    } else {
      Get.toNamed(Routes.payTerms);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UseTermsController>(
      builder: (terms) {
        return MobileLayout(
          needCenter: terms.isLoading.value || terms.useTermsModel == null,
          needScrollView: true,
          maxWidth: Responsive.maxWidth(),
          title: 'Termos e Políticas',
          appBarLeading: isDrawer ? const MenuButtom() : null,
          hasLeading: isDrawer,
          drawer:
              isDrawer ? const DrawerCustom(navbarItems: NaviItems()) : null,
          bodyChild: Column(
            children: [
              const UseTermsContent(),
              Visibility(
                visible: Responsive.isTabletOrDesktop() &&
                    (!terms.isLoading.value || terms.useTermsModel != null),
                child: GetBuilder<ScheduleController>(builder: (_) {
                  return UseTermsBottomActions(
                    isOnBottom: false,
                    isDrawer: isDrawer,
                    onContinue: () async {
                      await onContinue(_);
                    },
                  ).paddingOnly(top: 20);
                }),
              )
            ],
          ),
          bottomNavigationBar: Visibility(
            visible: !Responsive.isTabletOrDesktop() &&
                (!terms.isLoading.value || terms.useTermsModel != null),
            child: GetBuilder<ScheduleController>(builder: (_) {
              return UseTermsBottomActions(
                isDrawer: isDrawer,
                onContinue: () async {
                  await onContinue(_);
                },
              );
            }),
          ),
        );
      },
    );
  }
}
