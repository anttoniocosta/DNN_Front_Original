import 'package:dnn_core/all_exports.dart';
import 'package:get/get.dart';

class AccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IAccountRepository>(AccountRepository(Get.find()), permanent: true);
    Get.put<AccountController>(AccountController(Get.find()), permanent: true);
    Get.lazyPut<PhoneController>(() => PhoneController(Get.find()),
        fenix: true);
  }
}
