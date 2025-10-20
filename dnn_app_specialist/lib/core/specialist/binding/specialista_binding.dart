import 'package:dnn_app_specialist/core/specialist/controller/speacialist_controller.dart';
import 'package:dnn_app_specialist/core/specialist/repo/my_appointments_repo.dart';
import 'package:dnn_app_specialist/core/specialist/repo/speacialits_repo.dart';
import 'package:dnn_dependencies/get_export.dart';

import '../controller/my_appointments_controller.dart';

class SpecialistBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ISpecialistRepository>(
      SpecialistRepository(Get.find()),
      permanent: true,
    );
    Get.put<IMyAppointmentsRepository>(
      MyAppointmentsRepository(Get.find()),
      permanent: true,
    );
    Get.put<SpecialistController>(
      SpecialistController(repository: Get.find()),
      permanent: true,
    );
    Get.put<MyAppointmentsController>(
      MyAppointmentsController(repository: Get.find()),
      permanent: true,
    );
  }
}
