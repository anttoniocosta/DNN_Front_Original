import 'dart:async';
import 'dart:developer';

import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:dnn_streamming/dnn_streamming.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum StreammingTypeEnum { triagem, standard }

class MyAppointmentsController extends GetxController {
  final IMyAppointmentsRepository _repository;

  MyAppointmentsController(this._repository);

  List<MyAppointmentsResponseModel> myAppointmets = [];

  MyAppointmentsResponseModel? selectedAppoitment;
  ScreeningQueueModel? queuePosition;
  ScreeningQueueModel? finalQueuePosition;
  StartScreeningResponseModel? startTriagemModel;
  ScheduledFinalStatusModel? finalStatus;
  ScheduledFinalStatusModel? finalTriagemStatus;

  TextEditingController reasonController = TextEditingController();
  TextEditingController plaintController = TextEditingController();
  TextEditingController historyController = TextEditingController();
  TextEditingController mediciansController = TextEditingController();

  StreammingTypeEnum streammingType = StreammingTypeEnum.triagem;

  void setStreammingType(StreammingTypeEnum val) {
    streammingType = val;
    update();
  }

  RxBool isCancel = false.obs;

  setLoading(RxBool loading, bool val) {
    loading.value = val;
    update();
  }

  String? scheduleConsultationId = '';

  setScheduleConsultationId(String val) {
    scheduleConsultationId = val;
    update();
  }

  setController() {
    plaintController.text = selectedAppoitment!.mainComplaint ?? '';
    historyController.text = selectedAppoitment!.medicalHistory ?? '';
    mediciansController.text = selectedAppoitment!.currentMedication ?? '';
    update();
  }

  clearController() {
    plaintController.clear();
    historyController.clear();
    mediciansController.clear();
  }

  void clear() {
    selectedAppoitment = null;
    reasonController.clear();
  }

  void setAppointment(MyAppointmentsResponseModel? val) {
    selectedAppoitment = val;
    setScheduleConsultationId(selectedAppoitment!.id!);
    update();
  }

  Future<void> getMyAppointments() async {
    myAppointmets.clear();
    try {
      final result = await _repository.getMyAppointments();
      if (result.data != null) {
        myAppointmets = result.data!;
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  MyAppointmentsResponseModel? consultBought;

  Future<void> getConsultBought() async {
    consultBought = null;
    try {
      await getMyAppointments();
      consultBought = myAppointmets.firstWhereOrNull(
        (x) => x.id! == scheduleConsultationId!,
      );
      update();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> cancelAppointment() async {
    setLoading(isCancel, true);
    try {
      final result = await _repository.cancelAppointment({
        "id": selectedAppoitment!.id!,
        "reasonCancel": reasonController.text.trim(),
      });
      if (result.data != null) {
        Get.offNamedUntil(
          Routes.myAppointments,
          ModalRoute.withName(Routes.basePage),
        );
        SnackbarCustom.snackbarSucess(result.data!);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading(isCancel, false);
  }

  Future<bool> startTriagemQueue() async {
    bool isOk = false;
    try {
      final result = await _repository.startTriagemQueue(
        StartScreeningRequestModel(
          scheduleConsultationId: scheduleConsultationId,
          mainComplaint: plaintController.text,
          medicalHistory: historyController.text,
          currentMedication: mediciansController.text,
        ),
      );
      if (result.data != null) {
        isOk = true;
        startTriagemModel = result.data!;
        streammingController.generateToken(startTriagemModel!.screeningId!);
        update();
      }

      if (result.error != null) {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isOk;
  }

  Future<bool> startStandardQueue() async {
    bool isOk = false;
    try {
      final result = await _repository.startStandardQueue(
        StartStandardRequestModel(
          scheduleServiceId: selectedAppoitment!.channelName!,
          mainComplaint: plaintController.text,
          medicalHistory: historyController.text,
          currentMedication: mediciansController.text,
        ),
      );
      if (result.data != null) {
        isOk = true;
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isOk;
  }

  Future<bool> getTriagemQueuePosition() async {
    bool isOk = false;
    try {
      final result = await _repository.getTriagemQueuePosition(
        startTriagemModel!.screeningId!,
      );
      if (result.data != null) {
        queuePosition = result.data!;
        isOk = true;
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return isOk;
  }

  Future<bool> getStandardQueuePosition() async {
    bool isOk = false;
    try {
      final result = await _repository.getStandardQueuePosition();
      if (result.data != null) {
        finalQueuePosition = result.data!;
        isOk = true;
        update();
      }
      if (result.error != null) {
        log(result.error!.message!);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return isOk;
  }

  Future<bool> getScheduleStatus() async {
    bool isOk = false;
    try {
      final result = await _repository
          .getScheduleStatus(finalQueuePosition!.scheduleServicesId!);
      if (result.data != null) {
        finalStatus = result.data!;
        isOk = true;
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return isOk;
  }

  Future<bool> getScheduleTriagemStatus() async {
    bool isOk = false;
    try {
      final result = await _repository
          .getScheduleTriagemStatus(startTriagemModel!.screeningId!);
      if (result.data != null) {
        finalTriagemStatus = result.data!;
        isOk = true;
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return isOk;
  }

  Future<void> cancelTriagemQueue() async {
    setLoading(isCancel, true);
    try {
      final result = await _repository.cancelTriagemQueue(
        startTriagemModel!.screeningId!,
      );
      if (result.data != null) {
        navigationController.setIndex(NavigationTabs.home);
        Get.offAllNamed(Routes.basePage);
        SnackbarCustom.snackbarSucess(
            'Você saiu da fila de triagemcom sucesso!');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading(isCancel, false);
  }

  Future<void> cancelStardardQueue() async {
    if (finalQueuePosition?.scheduleServicesId == null) {
      SnackbarCustom.snackbarError('Aguarde um instante para sair da fila...');
      return;
    }
    setLoading(isCancel, true);
    try {
      final result = await _repository.cancelStardardQueue(
        finalQueuePosition!.scheduleServicesId ??
            selectedAppoitment!.channelName!,
      );
      if (result.data != null) {
        navigationController.setIndex(NavigationTabs.home);
        Get.offAllNamed(Routes.basePage);
        SnackbarCustom.snackbarSucess(result.data!);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading(isCancel, false);
  }

  //* PEGAR A SITUAÇÃO DAS FILAS
  void getQueuePosition({required String currentPage}) {
    Timer.periodic(
      const Duration(seconds: 5),
      (timer) async {
        if (Get.currentRoute != currentPage) {
          return timer.cancel();
        }
        switch (streammingType) {
          case StreammingTypeEnum.triagem:
            await getTriagemQueuePosition();
            if (queuePosition!.canOpenAgora == true) {
              streammingController.setClient(
                channelName: startTriagemModel!.screeningId!,
                clientType: ClientTypeEnum.patient,
                tokenId: '',
              );
              streammingController.setAgoraClient();
              Get.offAllNamed(Routes.streammingPatient);
              update();
              timer.cancel();
            }
            break;
          case StreammingTypeEnum.standard:
            await getStandardQueuePosition();
            if (finalQueuePosition!.canOpenAgora == true) {
              streammingController
                  .generateToken(finalQueuePosition!.scheduleServicesId!);
              streammingController.setClient(
                channelName: finalQueuePosition!.scheduleServicesId!,
                clientType: ClientTypeEnum.patient,
                tokenId: '',
              );
              streammingController.setAgoraClient();
              Get.offAllNamed(Routes.streammingPatient);
              update();
              timer.cancel();
            }
            break;
          default:
        }
      },
    );
  }

  Future<void> startStandardAppointment(String scheduleServicesId) async {
    final result = await startStandardQueue();
    if (result) {
      streammingController.generateToken(scheduleServicesId);
      streammingController.setClient(
        channelName: scheduleServicesId,
        clientType: ClientTypeEnum.patient,
        tokenId: '',
      );
      streammingController.setAgoraClient();
      Get.offAllNamed(Routes.streammingPatient);
      update();
    }
  }

  //* PEGAR A SITUAÇÃO DAS CONSULTAS
  void getScreeningStatus({required String currentPage}) {
    Timer.periodic(
      const Duration(seconds: 5),
      (timer) async {
        if (Get.currentRoute != currentPage) {
          return timer.cancel();
        }
        switch (streammingType) {
          case StreammingTypeEnum.triagem:
            await getScheduleTriagemStatus();
            if (finalTriagemStatus!.hasFinished == true) {
              streammingController.disposeEngine();
              setStreammingType(StreammingTypeEnum.standard);
              Get.offAllNamed(Routes.screenTriagemQueue);
              SnackbarCustom.snackbarSucess(
                'Triagem finalizada, que você será direcionado a fila de atendimento',
              );
              timer.cancel();
            }
            break;
          case StreammingTypeEnum.standard:
            await getScheduleStatus();
            if (finalStatus!.hasFinished == true) {
              SnackbarCustom.snackbarSucess(
                'Consulta finalizada pelo doutor, você será redirecionado ao início',
              );
              Future.delayed(const Duration(seconds: 1), () {
                streammingController.disposeEngine();
                navigationController.setIndex(NavigationTabs.home);
                Get.offAllNamed(Routes.basePage);
                setStreammingType(StreammingTypeEnum.triagem);
                timer.cancel();
              });
            }
            break;
          default:
        }
      },
    );
  }
}
