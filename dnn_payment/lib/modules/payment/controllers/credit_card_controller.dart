import 'package:dnn_core/all_exports.dart';
import 'package:dnn_core/core/common/loading.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_start_appointment/core/controllers/my_appointments_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';

class CreditCardController extends IPaymentController {
  final IPaymentV2Repository _repository;

  CreditCardController(this._repository);

  @override
  void onInit() {
    super.onInit();
    paymentResponse = null;
    paymentError = null;
    clear();
  }

  @override
  clear() {
    cardMask = '';
    paymentToken = '';
    brand = '';
    cardNumber = '';
    expiryDate = '';
    cardHolderName = '';
    cvvCode = '';
    isCvvFocused = false;
    providersController.clear();
    cpfEditC.clear();
    bithDayEditC.clear();
    update();
  }

  clearCard() {
    brand = '';
    cardNumber = '';
    expiryDate = '';
    cardHolderName = '';
    cvvCode = '';
    isCvvFocused = false;
    cardMask;
    paymentToken;
    cpfEditC.clear();
    bithDayEditC.clear();
    update();
  }

  RxBool isLoadingAddress = false.obs;
  RxBool isLoadingCCV = false.obs;
  RxBool isLoadingFinish = false.obs;
  RxBool isLoadingInstallments = false.obs;
  RxBool isMyAddress = false.obs;
  RxBool getPaymentDetails = false.obs;

  /// [DADOS_DO_CARTAO]
  String brand = '';
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String secondCvvCode = '';
  bool isCvvFocused = false;
  final cpfEditC = TextEditingController();
  final bithDayEditC = TextEditingController();
  final reasonEditC = TextEditingController();

  /// [RETORNO_GN_TOKEN]
  String? cardMask;
  String? paymentToken;

  /// [ULTIMOS_DIGITOS_PARA_TELA_DE_RESUMO]
  String get lastFourDigits => cardModel!.number!.split(' ').last;

  @override
  bool initializePaing = false;

  @override
  Future<void> payCart() async {
    final cicle = await storage.getPaymentCicle();
    if (cicle == PaymentEnum.PURCHASE) await payment();
    if (cicle == PaymentEnum.RENEWAL) await renewal();
    if (cicle == PaymentEnum.SCHEDULE) await schedule();
  }

  @override
  Future<void> payment() async {
    Loading.show(title: "Processando pagamento...");
    try {
      final result =
          await _repository.payment(payment: await requestModelCreditCard());

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

  @override
  Future<void> renewal() async {
    Loading.show(title: "Processando pagamento...");
    try {
      final result =
          await _repository.renewal(renewal: await requestModelCreditCard());

      if (result.data != null) {
        paymentResponse = result.data;
        update();
        await paymentDetailsController
            .getInvoicesPaymentDetail(paymentResponse!.paymentId!);
        Loading.hide();
        Get.offAllNamed(Routes.paymentStatus, arguments: paymentResponse);
      } else {
        Loading.hide();
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

  /// [GERENCIAR_ESTADOS_DOS_DADOS_NO_FORMS_DE_CARTAO]
  onCreditCardModelChange(CreditCardModel? creditCardModel) {
    cardNumber = creditCardModel!.cardNumber;
    expiryDate = creditCardModel.expiryDate;
    cardHolderName = creditCardModel.cardHolderName;
    cvvCode = creditCardModel.cvvCode;
    isCvvFocused = creditCardModel.isCvvFocused;
    update();
  }

  Future<void> getGnToken(String ccv, {bool? goToPayment = true}) async {
    final cardModel = cardController.card!;
    secondCvvCode = ccv;
    final api = GNApi(config: dnnController.config);
    try {
      var gnResponse = await api.retrievePaymentToken(
        GNCreditCard(
          brand: cardModel.brand!.toLowerCase(),
          cvv: ccv,
          expirationMonth: cardModel.expirationMonth!,
          expirationYear: cardModel.expirationYear!,
          number: cardModel.cardNumber!,
          salt: "",
        ),
      );
      if (gnResponse!.data != null &&
          (gnResponse.data?.paymentToken != null &&
              gnResponse.data?.cardMask != null)) {
        cardMask = gnResponse.data!.cardMask;
        paymentToken = gnResponse.data!.paymentToken;
        update();
        Get.toNamed(Routes.paymentChoiceAddress);
      } else {
        if (gnResponse.errorDescription != null) {
          SnackbarCustom.snackbarError(gnResponse.errorDescription!);
        }
      }
    } catch (e) {
      SnackbarCustom.snackbarException(e);
    }
  }

  PaymentCardModel setCreditCard() {
    UserAccountInfoModel? userData = accountController.userAccount;
    CardResponse? cardModel = cardController.card;
    PaymentCardModel creditCard = PaymentCardModel();
    creditCard.cardMask = cardModel!.cardNumberMask!;
    creditCard.brand = cardModel.brand;
    creditCard.document = cardModel.document!;
    creditCard.birth = cardModel.birthDate!.formatDateIso();
    creditCard.holderName = cardModel.holderName!;
    creditCard.paymentToken = paymentToken;
    creditCard.ipAddress = '';
    creditCard.recurringPayment = false;
    creditCard.installments = 1;

    if (!isMyAddress.value /*|| AppTrigger.isAppPartner */) {
      final address = providersController.adress!;
      creditCard.zipcode = address.cep;
      creditCard.street = address.logradouro;
      creditCard.number = providersController.number.text;
      creditCard.complement = address.complemento ?? '';
      creditCard.neighborhood = address.bairro;
      creditCard.city = address.localidade;
      creditCard.state = address.uf;
    } else {
      creditCard.zipcode = userData!.zipcode!;
      creditCard.street = userData.address!;
      creditCard.number = userData.number!;
      creditCard.complement = userData.complement!;
      creditCard.neighborhood = userData.neighborhood!;
      creditCard.city = userData.city!;
      creditCard.state = userData.state!;
    }
    return creditCard;
  }

  @override
  Future<void> schedule() async {
    setLoading(isLoading, true);
    try {
      final result = await _repository.schedule(
          schedule: await requestModelForScheduleCreditCard());

      if (result.data != null) {
        Get.toNamed(Routes.scheduleConclusion);
        update();
      }
      if (result.error != null) {
        paymentError = result.error;

        if (result.data != null) {
          Get.find<MyAppointmentsController>()
              .setScheduleConsultationId(result.data!.scheduleConsultationId!);
        }

        Get.offNamed(Routes.paymentError, arguments: paymentError!.message);
        update();
      }
    } catch (e) {
      Get.offNamed(Routes.paymentError, arguments: e.toString());
    }
    setLoading(isLoading, false);
  }
}
