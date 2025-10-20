import 'package:dnn_start_appointment/modules/schedule_appointment/export.dart';
import 'package:get/get.dart';

class ScheduleBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IScheduleRepository>(ScheduleRepository(Get.find()),
        permanent: true);
    Get.put<ScheduleController>(ScheduleController(repository: Get.find()),
        permanent: true);
  }
}
