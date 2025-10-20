import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:dnn_streamming/dnn_streamming.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreeningPatientPage extends StatefulWidget {
  const ScreeningPatientPage({super.key});

  @override
  State<ScreeningPatientPage> createState() => _ScreeningPatientPageState();
}

class _ScreeningPatientPageState extends State<ScreeningPatientPage>
    with WidgetsBindingObserver {
  final controller = Get.find<MyAppointmentsController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        streammingController.disposeEngine();
        accountController.getAccount();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAppointmentsController>(
      builder: (myapo) {
        return GetBuilder<MyAppointmentsController>(
          initState: (state) {
            myapo.getScreeningStatus(
              currentPage: Routes.streammingPatient,
            );
          },
          builder: (_) {
            return StreammingPage(
              needProntuary: false,
              onProntuaryTap: () {},
              finishCall: () {
                CustomDialogs.confirmDialog(
                  title: 'Deseja realmente sair da consulta?',
                  backAcion: () => Get.back(),
                  confirmAcion: () {
                    Get.back();
                    streammingController.disposeEngine();
                    navigationController.setIndex(NavigationTabs.home);
                    Get.offAllNamed(Routes.basePage);
                  },
                  context: context,
                  backVisible: true,
                );
              },
              titleText: 'Dr(a). ${_.selectedAppoitment!.doctor!.name!}',
              waitingText: 'Aguardando Dr(a)...',
            );
          },
        );
      },
    );
  }
}
