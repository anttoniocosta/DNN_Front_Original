import 'package:dnn_helpers/dnn_helpers.dart';
import 'package:get/get.dart';

class HelpersBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IHelpersRepository>(HelpersRepository(Get.find()), permanent: true);
    Get.put<HelpersController>(HelpersController(Get.find()), permanent: true);
  }
}
