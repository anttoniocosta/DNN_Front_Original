import 'package:dnn_core/all_exports.dart';
import 'package:dnn_core/core/common/loading.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';

import 'package:dnn_worker_payment/repository/worker_repository.dart';

class WorkerController extends GetxController {
  final IWorkerRepository _repository;

  Future<PaymentResquestModel> requestModel({
    required int typePaymentId,
    required String orderId,
    required String paymentId,
    required PaymentCardModel cardModel,
  }) async {
    return PaymentResquestModel(
        cartId: null,
        useTermsId: null,
        orderId: orderId,
        typePaymentId: typePaymentId,
        paymentIds: [paymentId],
        mercadoPagoId: null,
        card: (typePaymentId == GatewayEnum.CREDIT_MP) ? null : cardModel,
        mercadoPago: null);
  }

  WorkerController(this._repository);

  Future<void> renewal({
    required int typePaymentId,
    required String orderId,
    required String paymentId,
    required CardResponse cardModel,
  }) async {
    Loading.show(title: "Processando pagamento...");
    try {
      final result = await _repository.renewal(
          renewal: await requestModel(
        typePaymentId: typePaymentId,
        orderId: orderId,
        paymentId: paymentId,
        cardModel: setCreditCard(cardModel, ''),
      ));

      if (result.data != null) {
        update();
        Loading.hide();
      } else {
        Loading.hide();
      }
    } catch (e) {
      Loading.hide();
    }
  }

  PaymentCardModel setCreditCard(CardResponse cardModel, String paymentToken) {
    PaymentCardModel creditCard = PaymentCardModel();
    creditCard.cardMask = cardModel.cardNumberMask!;
    creditCard.brand = cardModel.brand;
    creditCard.document = cardModel.document!;
    creditCard.birth = cardModel.birthDate!.formatDateIso();
    creditCard.holderName = cardModel.holderName!;
    creditCard.paymentToken = paymentToken;
    creditCard.ipAddress = '';
    creditCard.recurringPayment = false;
    creditCard.installments = 1;

    // creditCard.zipcode = address.cep;
    // creditCard.street = address.logradouro;
    // creditCard.number = providersController.number.text;
    // creditCard.complement = address.complemento ?? '';
    // creditCard.neighborhood = address.bairro;
    // creditCard.city = address.localidade;
    // creditCard.state = address.uf;

    return creditCard;
  }
}
