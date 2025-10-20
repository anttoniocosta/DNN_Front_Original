import 'package:dnn_dependencies/get_export.dart';

import 'connectivity_controller.dart';

class ConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ConnectionManagerController>(ConnectionManagerController(),
        permanent: true);
  }
}
