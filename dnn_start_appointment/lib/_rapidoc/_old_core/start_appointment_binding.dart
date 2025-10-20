import 'package:dnn_start_appointment/core/export.dart';
import 'package:get/get.dart';

class StartAppointmentBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IStarAppointmentRepository>(
      StarAppointmentRepository(Get.find()),
      permanent: true,
    );
    Get.lazyPut<StartAppointmentController>(
      () => StartAppointmentController(Get.find()),
      fenix: true,
    );
  }
}
