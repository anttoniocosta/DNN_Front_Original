import 'dart:convert';
import 'dart:io';
import 'package:dnn_core/all_exports.dart';
import 'package:dnn_core/core/common/loading.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_dependencies/dnn_dependencies.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';

abstract class IPaymentController extends GetxController {
  PaymentResponseModel? paymentResponse;
  HttpError? paymentError;
  ClientModel? clientModel;

  /// [DADOS_PADROES]

  MercadoPagoRequest? get mercadoPagoModel => mercadoPagoController.mpRequest;
  PaymentCardModel? get cardModel => creditCardController.setCreditCard();

  Future<PaymentResquestModel> requestModelForStadard() async {
    final gatewayId = await storage.getGatewayId();
    final paymentCicle = await storage.getPaymentCicle();
    final useTermsId = await storage.getUseTerms();
    final cartId = await storage.getCartId();
    final orderId = await storage.getOrderId();
    final paymentIds = await storage.getGetPaymentIds();
    return PaymentResquestModel(
      cartId: (paymentCicle == PaymentEnum.PURCHASE) ? cartId : null,
      useTermsId: (paymentCicle == PaymentEnum.PURCHASE) ? useTermsId : null,
      orderId: (paymentCicle == PaymentEnum.RENEWAL) ? orderId : null,
      typePaymentId: gatewayId,
      paymentIds: (paymentCicle == PaymentEnum.PURCHASE) ? [] : paymentIds,
      mercadoPagoId: null,
      card: null,
      mercadoPago: null,
    );
  }

  Future<SchedulePaymentRequestModel> requestModelForSchedule() async {
    final gatewayId = await storage.getGatewayId();
    final useTermsId = await storage.getUseTerms();
    final isAnotherPatient = await storage.getIsAnotherPatient();
    final scheduleConsultationId = await storage.getScheduleConsultId();
    final model = await storage.getAccountForSchedule();
    PatientModel? patient;
    if (model != null && isAnotherPatient == true) {
      patient = PatientModel.fromProvider(model);
    }

    final modelFinal = SchedulePaymentRequestModel(
      useTermsId: useTermsId,
      typePaymentId: gatewayId,
      scheduleConsultationId: scheduleConsultationId,
      isAnotherPatient: isAnotherPatient!,
      patient: isAnotherPatient ? patient : null,
      mercadoPagoId: null,
      card: null,
      mercadoPago: null,
    );

    debugPrint(jsonEncode(modelFinal.toJson()).toString());
    return modelFinal;
  }

  Future<SchedulePaymentRequestModel>
      requestModelForScheduleCreditCard() async {
    final gatewayId = await storage.getGatewayId();
    final useTermsId = await storage.getUseTerms();
    final isAnotherPatient = await storage.getIsAnotherPatient();
    final scheduleConsultationId = await storage.getScheduleConsultId();
    final model = await storage.getAccountForSchedule();
    PatientModel? patient;
    if (model != null && isAnotherPatient == true) {
      patient = PatientModel.fromProvider(model);
    }
    final modelFinal = SchedulePaymentRequestModel(
      useTermsId: useTermsId,
      typePaymentId: gatewayId,
      scheduleConsultationId: scheduleConsultationId,
      isAnotherPatient: isAnotherPatient!,
      patient: isAnotherPatient ? patient : null,
      mercadoPagoId: null,
      card: (gatewayId == GatewayEnum.CREDIT_MP) ? null : cardModel,
      mercadoPago:
          (gatewayId == GatewayEnum.CREDIT_GNT) ? null : mercadoPagoModel,
    );
    debugPrint(jsonEncode(modelFinal.toJson()).toString());
    return modelFinal;
  }

  Future<PaymentResquestModel> requestModelCreditCard() async {
    final gatewayId = await storage.getGatewayId();
    final paymentCicle = await storage.getPaymentCicle();
    final useTermsId = await storage.getUseTerms();
    final cartId = await storage.getCartId();
    final orderId = await storage.getOrderId();
    final paymentIds = await storage.getGetPaymentIds();
    return PaymentResquestModel(
      cartId: (paymentCicle == PaymentEnum.PURCHASE) ? cartId : null,
      useTermsId: (paymentCicle == PaymentEnum.PURCHASE) ? useTermsId : null,
      orderId: (paymentCicle == PaymentEnum.RENEWAL) ? orderId : null,
      typePaymentId: gatewayId,
      paymentIds: (paymentCicle == PaymentEnum.PURCHASE) ? [] : paymentIds,
      mercadoPagoId: null,
      card: (gatewayId == GatewayEnum.CREDIT_MP) ? null : cardModel,
      mercadoPago:
          (gatewayId == GatewayEnum.CREDIT_GNT) ? null : mercadoPagoModel,
    );
  }

  void setClient() {
    clientModel = recoverClientModel;
    update();
  }

  ///[LOADINGS]
  RxBool isLoading = false.obs;
  setLoading(RxBool loading, bool val) {
    loading.value = val;
    update();
  }

  bool initializePaing = true;
  @override
  onInit() {
    super.onInit();
    paymentResponse = null;
    paymentError = null;
    if (initializePaing) payCart();
  }

  @override
  onClose() {
    super.onClose();
    clear();
  }

  clear() {
    paymentResponse = null;
    paymentError = null;
    mercadoPagoController.mpRequest = null;
  }

  Future<void> payCart();
  Future<void> renewal();
  Future<void> payment();
  Future<void> schedule();

  Future sharedBilletGenerate(String url) async {
    Loading.show(title: 'Baixando boleto');
    final gatewayId = await storage.getGatewayId();
    try {
      final directory = Platform.isAndroid
          ? (await getExternalStorageDirectory())!.path //FOR ANDROID
          : (await getApplicationSupportDirectory()).path; //FOR iOS

      final fileNameParts = url.split("/");

      String? filaName;
      if (gatewayId == GatewayEnum.BILLET_GNT) {
        filaName = fileNameParts[fileNameParts.length - 1].split('?').first;
      }

      if (gatewayId == GatewayEnum.BILLET_MP) {
        filaName = '${fileNameParts[fileNameParts.length - 2]}.pdf';
      }
      var response = await Dio(
        BaseOptions(
          connectTimeout: const Duration(minutes: 3),
          receiveTimeout: const Duration(minutes: 3),
        ),
      ).download(url, '$directory/$filaName');
      if (response.statusCode == 200) {
        await Share.shareXFiles(
          [XFile('$directory/$filaName')],
          text: 'Compartilhando boleto!',
        );
      } else {
        SnackbarCustom.snackbarError(
          "Não foi possível compartilhar o boleto. Tenta novamente!",
        );
      }
    } catch (e) {
      SnackbarCustom.snackbarException(e);
    }
    Loading.hide();
  }

  /// [DADOS_DO_CLIENTE_PARA_COMPRA_NO_APP_PARCEIRO]
  ClientModel get recoverClientModel {
    final account = providersController.setAccount();
    return ClientModel(
      contractId: null,
      document: account.document,
      name: account.name,
      birthday: account.birthday,
      email: account.email,
      phoneNumber: account.phoneNumber,
      gender: account.gender,
      firebaseToken: account.firebaseToken,
      address: account.address!,
    );
  }
}
