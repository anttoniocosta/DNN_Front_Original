import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';

class PixBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IPaymentV2Repository>(PaymentV2Repository(Get.find()),
        permanent: true);
    Get.lazyPut<PixController>(() => PixController(Get.find()), fenix: true);
    Get.put<PaymentDetailsController>(PaymentDetailsController(Get.find()),
        permanent: true);
  }
}
