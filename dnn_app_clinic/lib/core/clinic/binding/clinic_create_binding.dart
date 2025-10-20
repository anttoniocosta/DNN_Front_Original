import 'package:dnn_app_clinic/core/clinic/controller/update_specialist.dart';
import 'package:dnn_app_clinic/core/core.dart';
import 'package:get/get.dart';

class ClinicCreateBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IClinicRepository>(ClinicRepository(Get.find()), permanent: true);
    Get.put<ClinicAccountController>(
        ClinicAccountController(repository: Get.find()),
        permanent: true);
    Get.put<MySpecialistsController>(
        MySpecialistsController(repository: Get.find()),
        permanent: true);
    Get.put<MyAdsController>(MyAdsController(repository: Get.find()),
        permanent: true);
    Get.put<PublishAgendaController>(
        PublishAgendaController(repository: Get.find()),
        permanent: true);
    Get.put<MyDoctorsAppointmentsController>(
        MyDoctorsAppointmentsController(repository: Get.find()),
        permanent: true);
    Get.put<UpdateSpecialistController>(
        UpdateSpecialistController(repository: Get.find()),
        permanent: true);
  }
}

final mySpecialistsController = Get.find<MySpecialistsController>();
