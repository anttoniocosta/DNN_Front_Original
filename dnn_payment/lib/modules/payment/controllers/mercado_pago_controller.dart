import 'package:dnn_core/all_exports.dart';
import 'package:dnn_core/providers/mercadopago/card/card_model.dart';
import 'package:dnn_core/providers/mercadopago/card/installment_model.dart';
import 'package:dnn_core/providers/mercadopago/client/client_model.dart';
import 'package:dnn_core/providers/mercadopago/mercadopago_transparent.dart'
    as mercadopago;
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:flutter/material.dart';
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
    update();
  }

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
    update();
  }

  //* ESSE
  getInstallTments() async {
    installments = await dnnController.mercado.card.getInstallments(
      amount: gatewayController.totalPrice!,
      cardNumber: cardController.card!.firstSixDigits,
    );
    installmentSelected = installments;
    update();
  }

  //* --- main
  Future<void> addCreditCard(String ccv) async {
    try {
      await getMpClient();
      await createCreditCardToken(ccv);
      await createClientAndCard();
      await getInstallTments();
      update();
      Get.toNamed(Routes.paymentChoiceAddress);
    } catch (e) {
      SnackbarCustom.snackbarError(
        'Bandeira do cartão não suportada ou com erro nos dados informados.',
      );
    }
  }

  createClientAndCard() async {
    try {
      if (clientGet == null) {
        clientId = await dnnController.mercado.client.create(client: client!);
      }
      card = await dnnController.mercado.client
          .savecard(clientId: clientId!, token: token!);
      cardId = card!.id;
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getMpClient() async {
    try {
      clientGet = await dnnController.mercado.client.get(email: user!.email!);
      clientId = clientGet!.id;
      update();
    } catch (e) {
      SnackbarCustom.snackbarException(e);
    }
  }

  setChoicedCreditCard(CardMp cardMp) {
    card = cardMp;
    cardId = card!.id;
    update();
  }
}
