import 'package:dnn_streamming/modules/controller/streamming_controller.dart';
import 'package:get/get.dart';

class StreammingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<StreammingController>(StreammingController(), permanent: true);
  }
}
