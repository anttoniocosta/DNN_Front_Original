import 'package:dnn_core/all_exports.dart';
import 'package:dnn_core/core/common/loading.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class StartAppointmentController extends GetxController {
  final IStarAppointmentRepository _repository;

  StartAppointmentController(this._repository);

  RxBool isLoading = false.obs;
  setLoading(RxBool loading, bool val) {
    loading.value = val;
    update();
  }

  String? rapidocUrl;
  bool? hasPermission;
  List<InvoicePersonModel> dependents = [];

  Future<void> getPermission() async {
    Loading.show(title: 'Aguardando permissão...');
    try {
      final result = await _repository.getPermission();

      if (result.data != null) {
        hasPermission = result.data;
        Loading.hide();
        await getDependents();
      } else {
        Loading.hide();
        CustomDialogs.permissonDialog(campaignRoute: Routes.campaignMainOffers);
      }
    } catch (e) {
      Loading.hide();
      SnackbarCustom.snackbarException(e.toString());
    }
  }

  Future<bool> verifyPermissions() async {
    Loading.show(title: 'Verificando permissão...');
    bool canContinue = false;
    try {
      final result = await _repository.getPermission();

      if (result.data != null) {
        hasPermission = result.data;
        Loading.hide();
        canContinue = true;
      }
      if (result.error != null) {
        canContinue = false;
        Loading.hide();
      }
    } catch (e) {
      Loading.hide();
      debugPrint(e.toString());
    }
    return canContinue;
  }

  Future<void> getDependents({bool? forceUpdate = false}) async {
    Loading.show(title: 'Buscando dependentes...');
    try {
      final result = await _repository.getDependents();

      if (result.data != null) {
        dependents = result.data!;

        if (dependents.length > 1) {
          Loading.hide();
          Get.toNamed(Routes.serviceChoiceDependent);
        }

        if (dependents.length == 1) {
          Loading.hide();
          await startAppointment(dependents[0].personId!);
        }
      } else {
        if (result.error != null) {
          SnackbarCustom.snackbarError(result.error!.message!);
        }
      }
    } catch (e) {
      Loading.hide();
      SnackbarCustom.snackbarException(e.toString());
    }
  }

  Future<void> startAppointment(String personId) async {
    Loading.show(
        title: 'Aguarde enquanto lhe redirecionamos para o seu atendimento...');
    try {
      final result = await _repository.requestService(personId: personId);

      if (result.data != null) {
        rapidocUrl = result.data!.url;
        Loading.hide();
        Get.toNamed(Routes.serviceCall, arguments: rapidocUrl);
      } else {
        Loading.hide();
        if (result.error != null) {
          SnackbarCustom.snackbarError(result.error!.message!);
          Get.to(() => ErroPage(message: result.error!.message!));
        }
      }
    } catch (e) {
      Loading.hide();
      SnackbarCustom.snackbarError(e.toString());
    }
  }
}
