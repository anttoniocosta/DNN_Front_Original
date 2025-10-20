import 'package:dnn_app_clinic/core/core.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDoctorsAppointmentsController extends GetxController {
  final IClinicRepository _repository;

  MyDoctorsAppointmentsController({required IClinicRepository repository})
      : _repository = repository;

  List<AppointmentStatusModel> statusList = [];
  List<MyAppointmentsClinicResponseModel> myAppointments = [];
  MyAppointmentsClinicResponseModel? myAppointment;
  SpecialistResponseModel? specialist;
  AppointmentStatusModel? status;
  MyAppointmentsResponseModel? selectedAppoitment;
  RescheduleResponseModel? rescheduleModel;
  RescheduleDates? rescheduleDateSelected;
  RescheduleHours? rescheduleHourSelected;
  TextEditingController reasonController = TextEditingController();

  void setRescheduleDateSelected(RescheduleDates? val) {
    rescheduleDateSelected = val;
    update();
  }

  void setRescheduleHourSelected(RescheduleHours? val) {
    rescheduleHourSelected = val;
    update();
  }

  void setSelectedAppoitment(MyAppointmentsResponseModel? val) {
    selectedAppoitment = val;
    update();
  }

  void setRescheduleModel(RescheduleResponseModel? val) {
    rescheduleModel = val;
    update();
  }

  void setSpecialist(SpecialistResponseModel val) {
    specialist = val;
    update();
  }

  void setSelectedDate(MyAppointmentsClinicResponseModel val) {
    myAppointment = val;
    update();
  }

  void setStatus(AppointmentStatusModel val) {
    status = val;
    update();
  }

  clearLists() {
    statusList.clear();
    myAppointments.clear();
    specialist = null;
    status = null;
  }

  Future<bool> getStatus() async {
    bool isOk = false;
    LoadingDialog.show(Get.context!);
    try {
      final result = await _repository.getAppointmentsTypes(
        doctorId: specialist!.doctor!.doctorId!,
      );

      if (result.data != null) {
        LoadingDialog.hide(Get.context!);
        isOk = true;
        statusList = result.data!;

        update();
      }

      if (result.error != null) {
        LoadingDialog.hide(Get.context!);
        SnackbarCustom.snackbarError(result.error!.message!);
        isOk = false;
        update();
      }
    } catch (e) {
      LoadingDialog.hide(Get.context!);
      debugPrint(e.toString());
    }
    return isOk;
  }

  Future<bool> cancelAppointment() async {
    bool isOk = false;
    try {
      final result = await _repository.cancelAppointment({
        "id": selectedAppoitment!.id!,
        "reasonCancel": reasonController.text.trim(),
      });
      if (result.data != null) {
        isOk = true;
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isOk;
  }

  Future<bool> getDoctorAppointment() async {
    if (status!.quantity == 0) {
      SnackbarCustom.snackbarError('Não há registros para: ${status!.name!}');
      return false;
    }
    bool isOk = false;
    LoadingDialog.show(Get.context!);
    try {
      final result = await _repository.getAppointments(
        doctorId: specialist!.doctor!.doctorId!,
        statusId: status!.id!.toString(),
      );

      if (result.data != null) {
        LoadingDialog.hide(Get.context!);
        if (result.data!.isNotEmpty) {
          isOk = true;
        } else {
          isOk = false;
        }
        myAppointments = result.data!;
        update();
      }

      if (result.error != null) {
        LoadingDialog.hide(Get.context!);
        SnackbarCustom.snackbarError(result.error!.message!);
        isOk = false;
        update();
      }
    } catch (e) {
      LoadingDialog.hide(Get.context!);
      debugPrint(e.toString());
    }
    return isOk;
  }

  Future<bool> getReschedule(String scheduleConsultationId) async {
    bool isOk = false;
    try {
      final result = await _repository.getReschedule(
        scheduleConsultationId: scheduleConsultationId,
      );
      if (result.data != null) {
        isOk = true;
        setRescheduleModel(result.data!);
      }

      if (result.error != null) {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isOk;
  }

  Future<bool> putReschedule(ReschedulePutModel putModel) async {
    bool isOk = false;
    try {
      final result = await _repository.putReschedule(model: putModel);
      if (result.data != null) {
        isOk = true;
      }

      if (result.error != null) {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isOk;
  }
}
