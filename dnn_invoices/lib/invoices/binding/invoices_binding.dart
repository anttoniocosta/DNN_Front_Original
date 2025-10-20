import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_invoices/dnn_invoices.dart';

class InvoicesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IInvoicesRepository>(InvoicesRepository(Get.find()),
        permanent: true);
    Get.lazyPut<InvoicesController>(() => InvoicesController(Get.find()),
        fenix: true);
  }
}
