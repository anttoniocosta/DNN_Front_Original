import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_payment/modules/card/export.dart';
import 'package:dnn_payment/modules/payment/utils/payment_utils.dart';
import 'package:flutter/widgets.dart';

class CardController extends GetxController {
  final ICardRepository _repository;

  CardController(this._repository);

  RxBool isLoading = false.obs;
  RxBool canRegisterCard = true.obs;
  final ccv = TextEditingController();

  clear() {
    ccv.clear();
  }

  setIsLoading(bool val) {
    isLoading.value = val;
    update();
  }

  setCanRegisterCard(bool val) {
    canRegisterCard.value = val;
    update();
  }

  // @override
  // void onInit() async {
  //   await getCardList();
  //   super.onInit();
  // }

  List<CardResponse> cardList = [];
  CardResponse? card;

  Future<void> getCardList() async {
    setIsLoading(true);
    update();
    try {
      final result = await _repository.getListCards();

      if (result.data != null) {
        cardList = result.data!;
        update();
      } else {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      SnackbarCustom.snackbarException(e);
    }
    setIsLoading(false);
  }

  Future<void> saveCreditCard() async {
    // TODO: NÃO SALVAR QUANDO FOR PARCEIRO
    if (canRegisterCard.value == false) return;
    try {
      final result = await _repository.addCreditCard(
        model: setCardModel(),
      );

      if (result.data != null) {
        getCardList();
      }
    } catch (e) {
      SnackbarCustom.snackbarException(e);
    }
  }

  Future<void> deleteCreditCard(String id) async {
    setIsLoading(true);
    update();
    try {
      final result = await _repository.removeCreditCard(id: id);

      if (result.data != null) {
        SnackbarCustom.snackbarSucess(result.data!);
        await getCardList();
        Get.back();
        update();
      } else {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      SnackbarCustom.snackbarError(
        'Ocorreu um erro ao deletar o cartão, tente novamente!',
      );
    }
    setIsLoading(false);
  }

  CardResponse setCardModel() {
    final lastFourDigits = creditCardController.cardNumber.getLasFourDigits();
    final cardWithoutEncrypt = CardResponse(
      id: null,
      holderName: creditCardController.cardHolderName.capitalizeFirst,
      document: creditCardController.cpfEditC.text.trim().removeDocumentMask(),
      cardNumber: creditCardController.cardNumber.replaceAll(' ', ''),
      cardNumberMask: 'XXXXXXXXXXXX$lastFourDigits',
      expirationMonth: creditCardController.expiryDate.gnMonth(),
      expirationYear: creditCardController.expiryDate.gnYear(),
      issuer: creditCardController.brand.capitalizeFirst,
      brand: creditCardController.brand.capitalizeFirst,
      birthDate: creditCardController.bithDayEditC.text,
      code: creditCardController.cvvCode,
    );
    card = cardWithoutEncrypt;
    return cardWithoutEncrypt.encrypt();
  }

  setChoicedCard(CardResponse cardModel) {
    card = cardModel;
    update();
  }

  Future<void> verifyHasCards() async {
    await getCardList();
    if (cardList.isNotEmpty) Get.toNamed(Routes.creditCardList);
    if (cardList.isEmpty) Get.toNamed(Routes.creditCardInfos);

    // if (AppTrigger.isAppPartner) {
    //   Get.toNamed(Routes.creditCardInfos);
    // }
  }

  Future<void> creditCardInfoAction() async {
    if (creditCardController.brand == 'other') {
      PaymentUtils.selectCardBrand();
    } else {
      handleCreditCardInfoAction();
    }
  }

  Future<void> handleCreditCardInfoAction() async {
    setCardModel();
    setIsLoading(true);
    final gatewayId = await storage.getGatewayId();
    switch (gatewayId) {
      case GatewayEnum.CREDIT_GNT:
        await creditCardController.getGnToken(creditCardController.cvvCode);
        setIsLoading(false);
        break;
      case GatewayEnum.CREDIT_MP:
        await mercadoPagoController.addCreditCard(creditCardController.cvvCode);
        mercadoPagoController.setMercadoPago();
        setIsLoading(false);
        break;
      default:
    }
    cardController.saveCreditCard();
  }

  Future<void> creditIndefyCCVAction() async {
    final gatewayId = await storage.getGatewayId();
    try {
      setIsLoading(true);
      switch (gatewayId) {
        case GatewayEnum.CREDIT_GNT:
          await creditCardController.getGnToken(ccv.text);
          setIsLoading(false);
          break;
        case GatewayEnum.CREDIT_MP:
          await mercadoPagoController.addCreditCard(ccv.text);
          mercadoPagoController.setMercadoPago();
          setIsLoading(false);
          break;
        default:
      }
    } catch (e) {
      setIsLoading(false);
    }
  }
}
