import 'package:dnn_core/all_exports.dart';
import 'package:get/get.dart';

class UpdateAccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IAccountRepository>(AccountRepository(Get.find()), permanent: true);
    Get.lazyPut<UpdateAccountController>(
        () => UpdateAccountController(Get.find()),
        fenix: true);
  }
}
