import 'package:dnn_core/modules/export.dart';
import 'package:get/get.dart';

class QualityAssuranceBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IQARepository>(QARepository(Get.find()), permanent: true);
    Get.lazyPut<QualityAssuranceController>(
        () => QualityAssuranceController(Get.find()),
        fenix: true);
  }
}
