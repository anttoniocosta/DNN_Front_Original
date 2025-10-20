import 'package:dnn_app_specialist/core/specialist/repo/my_appointments_repo.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class MyAppointmentsController extends GetxController {
  final IMyAppointmentsRepository _repository;

  MyAppointmentsController({
    required IMyAppointmentsRepository repository,
  }) : _repository = repository;

  List<MyAppointmentsClinicResponseModel> myAppointments = [];

  MyAppointmentsClinicResponseModel? myAppointment;

  void setSelectedDate(MyAppointmentsClinicResponseModel val) {
    myAppointment = val;
    update();
  }

  clearLists() {
    myAppointments.clear();
  }

  Future<bool> getAppointments() async {
    bool isOk = false;
    LoadingDialog.show(Get.context!);
    try {
      final result = await _repository.getAppointments(
        doctorId: accountController.userAccount!.id!,
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
}
