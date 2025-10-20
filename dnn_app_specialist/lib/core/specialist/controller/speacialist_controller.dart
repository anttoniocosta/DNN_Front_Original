import 'dart:developer';

import 'package:dnn_app_specialist/core/specialist/repo/speacialits_repo.dart';
import 'package:dnn_app_specialist/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_streamming/dnn_streamming.dart';
import 'package:flutter/widgets.dart';

enum ScreeningCicle { triagem, ready, scheduled }

class SpecialistController extends GetxController {
  final ISpecialistRepository _repository;

  SpecialistController({required ISpecialistRepository repository})
      : _repository = repository;

  String id = accountController.userAccount?.user?.id ?? '';
  QueueResponseModel? selectedNextPatient;

  void setNextPatient(QueueResponseModel? val) {
    selectedNextPatient = val;
    update();
  }

  ScreeningCicle screeningCicle = ScreeningCicle.triagem;

  TextEditingController miniMedicalRecord = TextEditingController();

  setScreeningCicle(ScreeningCicle val) {
    screeningCicle = val;
    update();
  }

  RxBool isGetTriagem = false.obs;
  RxBool isStartTriagem = false.obs;
  RxBool isDutyLoading = false.obs;
  bool isOnDuty = false;

  setLoading(RxBool loading, bool val) {
    loading.value = val;
    update();
  }

  void clear() {
    selectedNextPatient = null;
  }

  List<QueueResponseModel> triagemList = [];
  List<QueueResponseModel> scheduledList = [];

  Future<void> startDuty() async {
    setLoading(isDutyLoading, true);
    try {
      final result = await _repository.startDuty();

      if (result.data != null) {
        isOnDuty = true;
        SnackbarCustom.snackbarSucess(result.data!);
        update();
      }

      if (result.error != null) {
        finishDuty();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading(isDutyLoading, false);
  }

  Future<void> isAlreadyOnDuty() async {
    if (isOnDuty) return;
    try {
      if (!(await storage.hasToken())) {
        isOnDuty = false;
        update();
        return;
      }

      final result = await _repository.isAlreadyOnDuty();

      if (result.data != null) {
        isOnDuty = result.data!;
        update();
      }

      if (result.error != null) {
        isOnDuty = false;
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> finishDuty() async {
    setLoading(isDutyLoading, true);
    try {
      final result = await _repository.finishDuty();

      if (result.data != null) {
        isOnDuty = false;

        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading(isDutyLoading, false);
  }

  Future<void> getQueueTriagem() async {
    setLoading(isGetTriagem, true);
    try {
      final result = await _repository.getQueueTriagem();

      if (result.data != null) {
        triagemList = result.data!.sortedBy((e) => e.position!).toList();
        update();
      }

      if (result.error != null) {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading(isGetTriagem, false);
  }

  Future<void> getQueues(bool isReady) async {
    setLoading(isGetTriagem, true);
    try {
      final result = await _repository.getQueues(isReady);

      if (result.data != null) {
        scheduledList = result.data!.sortedBy((e) => e.position!).toList();

        update();
      }

      if (result.error != null) {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading(isGetTriagem, false);
  }

  Future<void> startTriagem() async {
    setLoading(isStartTriagem, true);
    try {
      final result = await _repository.startTriagem(selectedNextPatient!.id!);

      if (result.data != null) {
        streammingController.generateToken(selectedNextPatient!.id!);
        streammingController.setClient(
          channelName: selectedNextPatient!.id!,
          clientType: ClientTypeEnum.doctor,
          tokenId: '',
        );
        streammingController.setAgoraClient();
        Get.toNamed(Routes.streammingTriagem);
      }

      if (result.error != null) {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading(isStartTriagem, false);
  }

  Future<void> closeTriagem() async {
    try {
      final result = await _repository.closeTriagem(
        ScheduledTriagemEndRequestModel(
          screeningId: selectedNextPatient!.id!,
          mainComplaint: selectedNextPatient!.mainComplaint!,
          medicalHistory: selectedNextPatient!.medicalHistory!,
          currentMedication: selectedNextPatient!.currentMedication!,
        ),
      );

      if (result.data != null) {
        navigationController.setIndex(NavigationTabs.home);
        Get.offAllNamed(Routes.basePage);
      }

      if (result.error != null) {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> startScheduled() async {
    setLoading(isStartTriagem, true);
    log('ID FINAL ${selectedNextPatient!.id!}');
    try {
      final result = await _repository.startScheduled(selectedNextPatient!.id!);

      if (result.data != null) {
        streammingController.generateToken(selectedNextPatient!.id!);
        streammingController.setClient(
          channelName: selectedNextPatient!.id!,
          clientType: ClientTypeEnum.doctor,
          tokenId: '',
        );
        streammingController.setAgoraClient();
        Get.toNamed(Routes.streammingDoctor);
      }

      if (result.error != null) {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading(isStartTriagem, false);
  }

  Future<void> closeScheduled() async {
    try {
      final result = await _repository.closeScheduled(
        ScheduledEndRequestModel(
          scheduleServicesId: selectedNextPatient!.id!,
          miniMedicalRecord: miniMedicalRecord.text,
        ),
      );

      if (result.data != null) {
        navigationController.setIndex(NavigationTabs.home);
        Get.offAllNamed(Routes.basePage);
        miniMedicalRecord.clear();
        SnackbarCustom.snackbarSucess(result.data!);
      }

      if (result.error != null) {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
