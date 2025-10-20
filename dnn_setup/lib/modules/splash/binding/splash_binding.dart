import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_setup/modules/splash/export.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController(), permanent: true);
  }
}
