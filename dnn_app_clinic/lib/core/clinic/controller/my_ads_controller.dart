import 'package:dnn_app_clinic/core/clinic/repository/clinic_repository.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:get/get.dart';

class MyAdsController extends GetxController {
  late final IClinicRepository _repository;

  MyAdsController({required IClinicRepository repository})
      : _repository = repository;

  setIsLoading(RxBool loading, bool state) {
    loading.value = state;
    update();
  }

  RxBool isLoadingDelete = false.obs;

  SpecialistResponseModel? selectedSpecialist;
  ScheduledDatesResponseModel? specialistAgenda;

  setSpecialistSelected(SpecialistResponseModel? value) {
    selectedSpecialist = value;
    update();
  }

  clear() {
    selectedDate = null;
    hoursToRemove = [];
    specialistAgenda = null;
  }

  ScheduledDates? selectedDate;
  List<ScheduledHours> hoursToRemove = [];

  void selectDay(ScheduledHours model) {
    if (hoursToRemove.firstWhereOrNull((x) => x.id == model.id) == null) {
      hoursToRemove.add(model);
      update();
    } else {
      hoursToRemove.removeWhere((x) => x == model);
      update();
    }
  }

  void setSelectedDate(ScheduledDates val) {
    selectedDate = val;
    update();
  }

  Future<bool> getSchedulesFromSpecialistId() async {
    if (selectedSpecialist?.id == null) return false;
    bool completeOk = false;
    LoadingDialog.show(Get.context!);
    try {
      final result = await _repository.getSchedulesFromSpecialistId(
        id: selectedSpecialist!.id!,
      );

      if (result.data != null) {
        specialistAgenda = result.data!;
        completeOk = true;
        update();
      }
      if (result.error != null) {
        SnackbarCustom.snackbarError(result.error!.message!);
        completeOk = false;
      }
    } catch (e) {
      SnackbarCustom.snackbarException(e);
      completeOk = false;
    }
    LoadingDialog.hide(Get.context!);

    return completeOk;
  }

  Future<bool> removeSchedules() async {
    bool completeOk = false;
    setIsLoading(isLoadingDelete, true);
    try {
      final result = await _repository.removeSchedules(
        scheduleIds: hoursToRemove.map((e) => e.id!).toList(),
      );

      if (result.data != null) {
        completeOk = true;
        update();
      }
      if (result.error != null) {
        SnackbarCustom.snackbarError(result.error!.message!);
        completeOk = false;
      }
    } catch (e) {
      SnackbarCustom.snackbarException(e);
      completeOk = false;
    }
    setIsLoading(isLoadingDelete, false);
    return completeOk;
  }
}
