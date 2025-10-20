import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_payment/modules/payment/controllers/faturar_controller.dart';

class FaturarBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IPaymentV2Repository>(PaymentV2Repository(Get.find()),
        permanent: true);
    Get.put<FaturarController>(FaturarController(Get.find()), permanent: true);
    Get.put<PaymentDetailsController>(PaymentDetailsController(Get.find()),
        permanent: true);
  }
}
