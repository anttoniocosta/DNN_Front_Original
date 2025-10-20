import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_payment/modules/payment/bindings/faturar_binding.dart';
import 'package:flutter/foundation.dart';

class GatewayController extends GetxController {
  final IGatewayRepository _repository;

  GatewayController(this._repository);

  RxBool isLoading = false.obs;
  setLoading(bool val) {
    isLoading.value = val;
    update();
  }

  List<GatewayDataModel> gatewayList = [];
  //GatewayDataModel? choicedGateway;
  int? paymentCycle;
  double? totalPrice;

  @override
  onInit() {
    getAllGateways();
    super.onInit();
  }

  Future<void> getAllGateways() async {
    setLoading(true);
    try {
      final result = await _repository.getAllGateways();
      if (result.data != null) {
        gatewayList = result.data!.data!;
        gatewayList.sort((a, b) => a.orders!.compareTo(b.orders!));

        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading(false);
  }

  Future<void> setPaymentCicle(int paymentEnum) async {
    await storage.setPaymentCicle(paymentEnum);
    paymentCycle = paymentEnum;
    update();
  }

  Future<void> progressWithPayment(int paymentCicle, double price) async {
    await setPaymentCicle(paymentCicle);
    paymentDetailsController.getPaymentCicle(paymentCicle);
    final gatewayId = await storage.getGatewayId();
    totalPrice = price;
    mercadoPagoController.setMpClient();
    update();
    setLoading(true);
    switch (gatewayId) {
      case GatewayEnum.PIX_GNT:
      case GatewayEnum.PIX_MP:
        await Get.toNamed(Routes.paymentResumePix);
        break;
      case GatewayEnum.CREDIT_GNT:
      case GatewayEnum.CREDIT_MP:
        await cardController.verifyHasCards();
        break;
      case GatewayEnum.BILLET_GNT:
      case GatewayEnum.BILLET_MP:
        await Get.toNamed(Routes.paymentResumeBoleto);
        break;

      case GatewayEnum.FATURAR:
        FaturarBinding().dependencies();
        faturarController.payCart();
    }
    setLoading(false);
  }

  clearChoiceGateway() {
    storage.removeGatewayId();
  }
}
