import 'package:dnn_dependencies/get_export.dart';

import '../export.dart';

class UseTermsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IUseTermsRepository>(UseTermsRepository(Get.find()),
        permanent: true);
    Get.put<UseTermsController>(UseTermsController(Get.find()));
  }
}
