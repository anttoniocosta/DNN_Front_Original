import 'dart:developer';

import 'package:dnn_core/all_exports.dart';
import 'package:dnn_core/providers/mercadopago/card/card_model.dart';
import 'package:dnn_core/providers/mercadopago/card/installment_model.dart';
import 'package:dnn_core/providers/mercadopago/client/client_model.dart';
import 'package:dnn_core/providers/mercadopago/mercadopago_transparent.dart'
    as mercadopago;
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:uuid/uuid.dart';

class MercadoPagoController extends GetxController {
  var uuid = const Uuid();
  String? clientId;
  String? cardId;
  Client? clientGet;
  Client? client;
  CardMp? card;
  String? token;
  InstallmentModel? installmentSelected;
  InstallmentModel? installments;
  PayerCosts? payerCost;
  MercadoPagoRequest? mpRequest;
  int? mercadoPagoId;

  UserAccountInfoModel? get user => accountController.userAccount;
  ClientModel? get clientModel => creditCardController.clientModel;

  RxBool isLoading = false.obs;
  setLoading(bool val) {
    isLoading.value = val;
    update();
  }

  clear() {
    client = null;
    clientGet = null;
    clientId = null;
    card = null;
    token = null;
    installmentSelected = null;
    installments = null;
    payerCost = null;
    mpRequest = null;
    mercadoPagoId = null;
  }

  MercadoPagoRequest? setMercadoPago() {
    try {
      return mpRequest = MercadoPagoRequest(
        clientId: clientId,
        tokenCard: token,
        //installments: payerCost?.installments ?? 1,
        installments: 1,
        paymentMethodId: card?.paymentMethodId!,
        issuerId: installmentSelected?.issuer?.id ?? '',
      );
    } catch (e) {
      return null;
    }
  }

  setPayerCost(PayerCosts payer) => payerCost = payer;

  setMpClient() {
    final name = user!.fullName!.split(' ');
    client = mercadopago.Client(
      firstName: name.first,
      lastName: name.last,
      email: user!.email!,
      docNumber: user!.document!.removeDocumentMask(),
      phone: user!.phoneNumber!,
    );
  }

  //   setMpClient() {
  //   final name = AppTrigger.isAppPartner
  //       ? clientModel!.name!.split(' ')
  //       : user!.fullName!.split(' ');
  //   client = mercadopago.Client(
  //     firstName: name.first,
  //     lastName: name.last,
  //     email: AppTrigger.isAppPartner ? clientModel!.email! : user!.email!,
  //     docNumber: AppTrigger.isAppPartner
  //         ? clientModel!.document!.removeCpfMask()
  //         : user!.document!.removeCpfMask(),
  //     phone: AppTrigger.isAppPartner
  //         ? clientModel!.phoneNumber!
  //         : user!.phoneNumber!,
  //   );
  // }

  //* ESSE
  Future<void> createCreditCardToken(String ccv) async {
    final cardModel = cardController.card;
    token = await dnnController.mercado.card.token(
      cardName: !dnnController.isSandboxMp ? 'APRO' : cardModel!.holderName!,
      cpf: cardModel!.document!.removeDocumentMask(),
      cardNumber: cardModel.cardNumber!,
      expirationMoth: int.parse(cardModel.expirationMonth!),
      expirationYear: int.parse(cardModel.expirationYear!),
      securityCode: ccv,
      issuer: 'DNN',
    );
  }

  //* ESSE
  getInstallTments() async {
    installments = await dnnController.mercado.card.getInstallments(
      amount: gatewayController.totalPrice!,
      cardNumber: cardController.card!.firstSixDigits,
    );
    installmentSelected = installments;
  }

  //* --- main
  Future<void> addCreditCard(String ccv) async {
    try {
      await getMpClient();
      await createCreditCardToken(ccv);
      await createClientAndCard();
      await getInstallTments();
      Get.toNamed(Routes.paymentChoiceAddress);
    } catch (e) {
      SnackbarCustom.snackbarError(
        'Bandeira do cartão não suportada ou com erro nos dados informados.',
      );
    }
    // if (mainPlan!.isSubscription!) {
    //   Get.toNamed(Routes.paymentChoiceAddress);
    // } else {
    //   await getInstallTments();
    //   Get.toNamed(Routes.paymentChoiceAddress);
    // }
  }

  //
  // Future<void> createSecondToken({required String ccv}) async {
  //   token = await dnnController.mercado.card.tokenWithCard(
  //     cardId: cardId!,
  //     securityCode: ccv,
  //   );
  // }

  // Future<int> creditCardSubscription() async {
  //   final result = await dnnController.mercado.subscriptions.create(
  //     externalReference: uuid.v1().toString(),
  //     description: mainPlan!.name!,
  //     frequency: mainPlan!.recurrence!,
  //     token: token!,
  //     type: 'months',
  //     repetition: mainPlan!.months,
  //     email: AppTrigger.isAppPartner ? clientModel!.email! : user!.email!,
  //     amount: mainPlan!.price!,
  //   );

  //   Logs.p.i('=================================');
  //   Logs.p.i(mercadoPagoId);
  //   Logs.p.i('=================================');
  //   mercadoPagoId = num.parse(result.id!).toInt();

  //   return mercadoPagoId!;
  // }

  // Future<void> getSecondTokenAndInstallments(String ccv) async {
  //   setLoading(true);
  //   update();
  //   await mercadoPagoController.createSecondToken(ccv: ccv);
  //   if (mainPlan!.isSubscription!) {
  //     Get.toNamed(Routes.resumeMp);
  //   } else {
  //     await mercadoPagoController.getInstallTments();
  //     Get.toNamed(Routes.installmentsMp);
  //   }

  //   setLoading(false);
  // }

  createClientAndCard() async {
    try {
      if (clientGet == null) {
        clientId = await dnnController.mercado.client.create(client: client!);
      }
      card = await dnnController.mercado.client
          .savecard(clientId: clientId!, token: token!);
      cardId = card!.id;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getMpClient() async {
    try {
      clientGet = await dnnController.mercado.client.get(email: user!.email!);
      // email: AppTrigger.isAppPartner ? clientModel!.email! : user!.email!);
      clientId = clientGet!.id;
    } catch (e) {
      SnackbarCustom.snackbarException(e);
    }
    //await verifyClientGetted();
  }

  setChoicedCreditCard(CardMp cardMp) {
    card = cardMp;
    cardId = card!.id;
  }

  // verifyClientGetted() async {
  //   if (clientGet == null) {
  //     return;
  //     //Get.toNamed(Routes.creditCardInfoMp);
  //   } else {
  //     await createClientAndCard();
  //     clientId = clientGet!.id;
  //     // if (clientGet!.cards!.isNotEmpty) {
  //     //   Get.toNamed(Routes.creditCardListMp);
  //     // } else {
  //     //   Get.toNamed(Routes.creditCardInfoMp);
  //     // }
  //   }
  // }

  // Future<void> paymentByCredit() async {
  //   try {
  //     final credit = await mercado.payment.creditCard(
  //       tokenCard: token!,
  //       clientId: clientId!,
  //       amount: mainPlan!.price!,
  //       paymentMethodId: card!.paymentMethodId!,
  //       description: mainPlan!.name!,
  //       externalReference: uuid.v1().toString(),
  //       issuer: installmentSelected!.issuer!.id!,
  //       installments: payerCost!.installments!,
  //     );
  //   } catch (e) {
  //     Get.offNamed(Routes.paymentError,
  //         arguments: 'Houve um erro para processaro pagamento.');
  //   }
  // }
}
