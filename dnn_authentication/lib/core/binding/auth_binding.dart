import 'package:dnn_authentication/core/controllers/authentication_controller.dart';
import 'package:dnn_authentication/core/repositories/authentication_repository.dart';
import 'package:get/get.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IAuthenticationRepository>(AuthenticationRepository(Get.find()),
        permanent: true);
    Get.put<AuthenticationController>(AuthenticationController(Get.find()),
        permanent: true);
  }
}
