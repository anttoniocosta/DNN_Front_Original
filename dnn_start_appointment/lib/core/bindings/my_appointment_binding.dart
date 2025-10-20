import 'package:dnn_start_appointment/core/export.dart';
import 'package:get/get.dart';

class MyAppointmentsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IMyAppointmentsRepository>(MyAppointmentsRepository(Get.find()),
        permanent: true);
    Get.put<MyAppointmentsController>(MyAppointmentsController(Get.find()),
        permanent: true);
  }
}
