import 'package:dnn_core/all_exports.dart';
import 'package:get/get.dart';

class PhoneController extends GetxController {
  final IAccountRepository _repository;

  PhoneController(this._repository);

  String? get userPhoneNumber => accountController.userAccount!.phoneNumber;
  String? get userToken => accountController.userCreated!.accessToken;

  RxBool isLoading = false.obs;
  setLoading(bool val) {
    isLoading.value = val;
    update();
  }

  /*
  * Iniciado na tela de OTP, chama a API que enviar o código de SMS para o número.
  */
  Future<void> getPincode() async {
    if (accountController.userAccount!.phoneNumberConfirmed! == true) return;

    try {
      final result = await _repository.sendPhoneForPincodeSMS(
        phoneNumber: userPhoneNumber!,
      );
      if (result.data != null) {
        SnackbarCustom.snackbarSucess(result.data!);
      } else {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      SnackbarCustom.snackbarException(e.toString());
    }
  }

  /* 
  * Valida o número telefone, chama a base page novamente e após isso
  * a tela incial.
  */
  Future<void> phoneValidation(
      String pinCode, String token, String phoneNumber) async {
    setLoading(true);
    try {
      final result = await _repository.phoneValidation(
        pinCode: pinCode,
        phoneNumber: phoneNumber,
      );

      if (result.data != null) {
        await accountController.getAccount();
        SnackbarCustom.snackbarSucess(result.data!);
        navigationController.setIndex(NavigationTabs.home);
        Get.offAllNamed(Routes.basePage);
      } else {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      SnackbarCustom.snackbarException(e.toString());
    }
    setLoading(false);
  }
}
