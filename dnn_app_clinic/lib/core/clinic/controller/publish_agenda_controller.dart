import 'dart:developer';

import 'package:dnn_app_clinic/core/clinic/repository/clinic_repository.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PublishAgendaController extends GetxController {
  late final IClinicRepository _repository;

  PublishAgendaController({required IClinicRepository repository})
      : _repository = repository;

  setIsLoading(RxBool loading, bool state) {
    loading.value = state;
    update();
  }

  @override
  void onInit() {
    getTypeSchedule();
    super.onInit();
  }

  RxBool isLoadingCreate = false.obs;

  SpecialistResponseModel? selectedSpecialist;
  List<TypeScheduleResponse> typeSchedules = [];

  TextEditingController hourController = TextEditingController();
  TextEditingController scheduleTypeController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  void clearPrice() {
    priceController.clear();
    update();
  }

  bool checkPrice(String val) {
    if (val.isEmpty) return false;
    return returnNumber(val) > 1.00;
  }

  double returnNumber(String val) {
    return double.parse(
      val.replaceFirst('R\$', '').replaceAll('.', '').replaceAll(',', '.'),
    );
  }

  int getScheduleTypeId(String text) {
    return typeSchedules.firstWhere((x) => x.name == text).id!;
  }

  String getScheduleTypeName(int id) {
    return typeSchedules.firstWhere((x) => x.id == id).name!;
  }

  setSpecialistSelected(SpecialistResponseModel? value) {
    selectedSpecialist = value;
    update();
  }

  bool isReadyService = false;
  bool isAcceptsDnnPlan = false;

  setIsReadyService(bool val) {
    isReadyService = val;
    update();
  }

  void clear() {
    selectedDays.clear();
    publisListHours.clear();
    isReadyService = false;
    isAcceptsDnnPlan = false;
    update();
  }

  void clearPlantonista() {
    priceController.clear();
    selectedDays.clear();
    publisListHours.clear();
    isAcceptsDnnPlan = false;
  }

  void clearHour() {
    hourController.clear();
    scheduleTypeController.text = '';
    priceController.clear();
    update();
  }

  void setScheduleTypeController(String val) {
    scheduleTypeController.text = val;
    update();
  }

  List<CalendarEvent> selectedDays = [];
  List<PublishHours> publisListHours = [];

  void addHourToPublish(PublishHours model) {
    if (publisListHours.firstWhereOrNull((x) => x.hour == model.hour) == null) {
      publisListHours.add(model);
      publisListHours.sort((a, b) => a.hour!.compareTo(b.hour!));
      clearHour();
      update();
    } else {
      SnackbarCustom.snackbarError('Este horário já foi adicionado.');
    }
  }

  void removeHourToPublish(PublishHours model) {
    publisListHours.removeWhere((x) => x == model);
    update();
  }

  void setSelectedDays(DateTime day) {
    final event = CalendarEvent(uid: '', day: day, isLowCost: false, price: 0);
    if (containsThisDay(day)) {
      selectedDays.removeWhere((x) => x.day == event.day);
      update();
    } else {
      selectedDays.add(event);
      update();
    }
  }

  bool containsThisDay(DateTime day) {
    return selectedDays.firstWhereOrNull((x) => x.day == day) != null;
  }

  Future<void> getTypeSchedule() async {
    try {
      final result = await _repository.getTypeSchedule();
      if (result.data != null) {
        typeSchedules = result.data!;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> postPublishAgenda() async {
    setIsLoading(isLoadingCreate, true);
    bool postOk = false;
    final model = PublishAgendaRequestModel(
      clinicSpecialistId: selectedSpecialist!.id,
      price: isReadyService
          ? priceController.text.isNotEmpty
              ? returnNumber(priceController.text)
              : selectedSpecialist!.price!
          : null,
      typeScheduleId: isReadyService
          ? getScheduleTypeId(scheduleTypeController.text)
          : null,
      hours: publisListHours,
      isAcceptsDnnPlan: isAcceptsDnnPlan,
      isReadyService: isReadyService,
      dates: selectedDays.map((e) => e.day.toIso8601String()).toList(),
    );

    log(model.toJson().toString());

    try {
      final result = await _repository.postPublishAgenda(model);
      if (result.data != null) {
        postOk = true;
        setIsLoading(isLoadingCreate, false);
      }
      if (result.error != null) {
        setIsLoading(isLoadingCreate, false);
        SnackbarCustom.snackbarError(result.error!.message!);
        postOk = false;
      }
    } catch (e) {
      setIsLoading(isLoadingCreate, false);
      SnackbarCustom.snackbarException(e);
    }
    setIsLoading(isLoadingCreate, false);
    return postOk;
  }

  Future<void> checkHour(PublishHours model) async {
    LoadingDialog.show(Get.context!);
    try {
      final request = PublishAgendaCheckModel(
        clinicSpecialistId: selectedSpecialist!.id,
        hour: model.hour,
        isAcceptsDnnPlan: isAcceptsDnnPlan,
        isReadyService: isReadyService,
        dates: selectedDays.map((e) => e.day.toIso8601String()).toList(),
        typeScheduleId: model.typeScheduleId,
      );

      final result = await _repository.checkHour(request);

      if (result.data != null) {
        LoadingDialog.hide(Get.context!);
        addHourToPublish(model);
      }

      if (result.error != null) {
        LoadingDialog.hide(Get.context!);
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      LoadingDialog.hide(Get.context!);
      SnackbarCustom.snackbarException(e);
    }
  }
}
