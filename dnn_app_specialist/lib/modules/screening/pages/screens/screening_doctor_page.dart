import 'package:dnn_app_specialist/core/specialist/controller/speacialist_controller.dart';
import 'package:dnn_app_specialist/modules/screening/export.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_streamming/dnn_streamming.dart';
import 'package:flutter/material.dart';

class ScreeningDoctorPage extends StatefulWidget {
  const ScreeningDoctorPage({super.key});

  @override
  State<ScreeningDoctorPage> createState() => _ScreeningDoctorPageState();
}

class _ScreeningDoctorPageState extends State<ScreeningDoctorPage>
    with WidgetsBindingObserver {
  final specialist = Get.find<SpecialistController>();
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
        specialist.closeTriagem();
        streammingController.disposeEngine();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecialistController>(builder: (specialist) {
      return StreammingPage(
        onProntuaryTap: () {
          showDialog(
            context: context,
            builder: (_) {
              return const Dialog.fullscreen(
                child: ProntuaryWidget(needButtons: false),
              );
            },
          );
        },
        finishCall: () {
          showDialog(
            context: context,
            builder: (_) {
              return const Dialog.fullscreen(
                child: DoctorFinishCallWidget(),
              );
            },
          );
        },
        titleText: 'Paciente: ${specialist.selectedNextPatient!.fullName!}',
        waitingText: 'Aguardando paciente',
      );
    });
  }
}
