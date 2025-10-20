import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';

class CreditCardBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IPaymentV2Repository>(PaymentV2Repository(Get.find()),
        permanent: true);
    Get.put<MercadoPagoController>(MercadoPagoController(), permanent: true);
    Get.put<CreditCardController>(CreditCardController(Get.find()),
        permanent: true);
    Get.put<PaymentDetailsController>(PaymentDetailsController(Get.find()),
        permanent: true);
  }
}
