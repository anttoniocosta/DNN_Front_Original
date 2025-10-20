import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';

class BilletBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IPaymentV2Repository>(PaymentV2Repository(Get.find()));
    Get.put<BilletController>(BilletController(Get.find()));
    Get.put<PaymentDetailsController>(PaymentDetailsController(Get.find()),
        permanent: true);
  }
}
