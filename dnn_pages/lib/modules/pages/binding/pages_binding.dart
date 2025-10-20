import 'package:dnn_pages/dnn_pages.dart';
import 'package:get/get.dart';

class PagesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IPagesRepository>(PagesRepository(Get.find()), permanent: true);
    Get.put<PagesController>(PagesController(Get.find()), permanent: true);
  }
}
