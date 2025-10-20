import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QueueSchedulePage extends StatefulWidget {
  const QueueSchedulePage({super.key});

  @override
  State<QueueSchedulePage> createState() => _QueueSchedulePageState();
}

class _QueueSchedulePageState extends State<QueueSchedulePage>
    with WidgetsBindingObserver {
  final myAppointmentController = Get.find<MyAppointmentsController>();
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
        myAppointmentController.cancelTriagemQueue();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAppointmentsController>(initState: (__) {
      myAppointmentController.getQueuePosition(
        currentPage: Routes.screenTriagemQueue,
      );
    }, builder: (_) {
      return PopScope(
        onPopInvoked: (val) async {
          CustomDialogs.confirmDialog(
            title: 'Deseja realmente sair da fila?',
            backAcion: () => Get.back(),
            confirmAcion: () {
              Get.back();
              switch (_.streammingType) {
                case StreammingTypeEnum.triagem:
                  _.cancelTriagemQueue();
                  break;
                case StreammingTypeEnum.standard:
                  _.cancelStardardQueue();
                  break;
                default:
              }
            },
            context: context,
            backVisible: true,
          );
        },
        canPop: false,
        child: MobileLayout(
          needCenter: true,
          needScrollView: true,
          title: 'Fila de espera',
          hasLeading: true,
          appBarLeading: const SizedBox(),
          bodyChild: Column(
            children: [
              Text(
                switch (_.streammingType) {
                  StreammingTypeEnum.triagem =>
                    'Sua posição na fila de atendimento para triagem',
                  StreammingTypeEnum.standard =>
                    'Sua posição na fila de atendimento para sua consulta',
                },
                style: Fonts.headlineMedium(context),
                textAlign: TextAlign.center,
              ).paddingOnly(bottom: 26),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 26),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.blueDarkColor,
                ),
                child: switch (_.streammingType) {
                  StreammingTypeEnum.standard => Text(
                      _.finalQueuePosition?.position?.toString() == null
                          ? 'Buscando posição...'
                          : _.finalQueuePosition!.position!.toString(),
                      style: Fonts.displayLarge(context).copyWith(
                        color: AppColors.whiteColor,
                        fontSize: _.finalQueuePosition == null ||
                                _.finalQueuePosition!.position! == 0
                            ? 20
                            : null,
                      ),
                    ).toCenter,
                  StreammingTypeEnum.triagem => Text(
                      _.queuePosition?.position?.toString() ??
                          'Buscando posição...',
                      style: Fonts.displayLarge(context).copyWith(
                        color: AppColors.whiteColor,
                        fontSize: _.queuePosition == null ? 20 : null,
                      ),
                    ).toCenter
                },
              ).paddingOnly(bottom: 20),
              Text(
                'Você será atendido em breve, por favor aguarde!',
                style: Fonts.headlineMedium(context),
                textAlign: TextAlign.center,
              ).paddingOnly(bottom: 26),
              const CircularProgressIndicator.adaptive()
                  .paddingOnly(bottom: 26),
              SecondaryButtonWidget(
                onTap: () {
                  CustomDialogs.confirmDialog(
                    title: 'Deseja realmente sair da fila?',
                    backAcion: () => Get.back(),
                    confirmAcion: () {
                      Get.back();
                      switch (myAppointmentController.streammingType) {
                        case StreammingTypeEnum.triagem:
                          _.cancelTriagemQueue();
                          break;
                        case StreammingTypeEnum.standard:
                          _.cancelStardardQueue();
                        default:
                      }
                    },
                    context: context,
                    backVisible: true,
                  );
                },
                titleButtom: 'Sair da fila',
              )
            ],
          ),
        ),
      );
    });
  }
}
