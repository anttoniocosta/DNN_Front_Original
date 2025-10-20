import 'package:dnn_app_clinic/core/clinic/repository/clinic_repository.dart';
import 'package:dnn_authentication/dnn_authentication.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClinicAccountController extends GetxController {
  late final IClinicRepository _repository;

  ClinicAccountController({required IClinicRepository repository})
      : _repository = repository;

  void setIsLoading(RxBool loading, bool state) {
    loading.value = state;
    update();
  }

  RxBool isLoading = false.obs;
  bool hasScreening = false;
  TextEditingController passwordCtrl = TextEditingController();

  void clear() {
    hasScreening = false;
    passwordCtrl.clear();
    providersController.clear();
  }

  void setHasScreening(bool val) {
    hasScreening = val;
    update();
  }

  Future<void> createClinic(AccountRequestModel account) async {
    setIsLoading(isLoading, true);
    try {
      final clinicDataParams = CreateClinicParams.fromProvider(account);
      clinicDataParams.passwordHash = passwordCtrl.text;
      clinicDataParams.hasScreening = hasScreening;

      final result = await _repository.createClinic(params: clinicDataParams);

      if (result.data != null) {
        await authenticationController.signIn(
          () {
            navigationController.setIndex(0);
            Get.offAllNamed(Routes.basePage);
            SnackbarCustom.snackbarSucess(result.data!);
            clear();
          },
          loginModel: LoginModel(
            login: clinicDataParams.document!,
            password: clinicDataParams.passwordHash,
          ),
        );
      }
      if (result.error != null) {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      SnackbarCustom.snackbarException(e);
    }
    setIsLoading(isLoading, false);
  }
}
