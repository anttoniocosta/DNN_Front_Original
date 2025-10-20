import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_setup/dnn_setup.dart';
import 'package:dnn_setup/modules/app_version/export.dart';
import 'package:flutter/foundation.dart';

class InitializeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<InitializeController>(InitializeController(), permanent: true);
    if (!kIsWeb) {
      Get.put<IAppVersionRepository>(
        AppVersionRepository(Get.find()),
        permanent: true,
      );
      Get.put<AppVersionController>(
        AppVersionController(Get.find()),
        permanent: true,
      );
    }
  }
}
