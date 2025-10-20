import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';

class GatewayBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IGatewayRepository>(GatewayRepository(Get.find()), permanent: true);
    Get.lazyPut<GatewayController>(() => GatewayController(Get.find()),
        fenix: true);
  }
}
