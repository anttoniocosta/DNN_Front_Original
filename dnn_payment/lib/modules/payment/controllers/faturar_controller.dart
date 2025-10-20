import 'package:dnn_core/all_exports.dart';
import 'package:dnn_core/core/common/loading.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';

class FaturarController extends IPaymentController {
  final IPaymentV2Repository _repository;

  FaturarController(this._repository);

  @override
  void onInit() {
    super.onInit();
    paymentResponse = null;
    paymentError = null;
    clear();
  }

  @override
  bool initializePaing = false;

  @override
  Future<void> payCart() async {
    await payment();
  }

  @override
  Future<void> payment() async {
    Loading.show(title: "Processando pedido...");
    try {
      final result =
          await _repository.payment(payment: await requestModelForStadard());

      if (result.data != null) {
        paymentResponse = result.data;
        update();
        await paymentDetailsController
            .getInvoicesPaymentDetail(paymentResponse!.paymentId!);
        Loading.hide();
        Get.offAllNamed(Routes.paymentStatus, arguments: paymentResponse);
      } else {
        _handleError(result.error!.message!);
      }
    } catch (e) {
      Loading.hide();
      _handleError(e.toString());
    }
  }

  _handleError(String error) async {
    Get.toNamed(Routes.paymentError, arguments: error);
  }

  @override
  Future<void> renewal() {
    throw UnimplementedError();
  }

  @override
  Future<void> schedule() {
    // TODO: implement schedule
    throw UnimplementedError();
  }
}
