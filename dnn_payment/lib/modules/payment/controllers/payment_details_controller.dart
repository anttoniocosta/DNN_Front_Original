import 'dart:async';
import 'dart:developer';

import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:flutter/material.dart';

class PaymentDetailsController extends GetxController {
  final IPaymentV2Repository _repository;

  PaymentDetailsController(this._repository);

  RxBool getPaymentDetails = false.obs;

  InvoicePaymentDetailsModel? paymentDetails;
  SchedulePaymentDetailsModel? scheduleDetails;
  int? paymentCicle;

  setLoading(RxBool loading, bool val) {
    loading.value = val;
    update();
  }

  getPaymentCicle(int cicle) {
    paymentCicle = cicle;
    log("Payment Cicle: ${paymentCicle == 1 ? 'compra' : 'renovação'}");
    update();
  }

  getPaymentContract(
      {PaymentResponseModel? paymentResponse, required String currentPage}) {
    Timer.periodic(
      const Duration(seconds: 4),
      (timer) async {
        if (Get.currentRoute != currentPage) {
          return timer.cancel();
        }
        if (paymentResponse != null) {
          debugPrint('Buscando dados do pagamento');
          await getInvoicesPaymentDetail(paymentResponse.paymentId!);
          if (paymentDetails != null) {
            debugPrint('A venda está: ${paymentDetails!.isPaid!}');
            if (paymentDetails!.isPaid!) {
              final paied = paymentResponse;
              paied.paymentConfirmed = true;

              getInvoicesPaymentDetail(paymentResponse.paymentId!);

              if (await storage.getPaymentCicle() == 3) {
                Get.toNamed(Routes.scheduleConclusion);
              } else {
                Get.offAllNamed(Routes.paymentStatus, arguments: paied);
              }
              update();
              timer.cancel();
            }
          }
        }
      },
    );
  }

  getPaymentSchedule(
      {PaymentResponseModel? paymentResponse, required String currentPage}) {
    Timer.periodic(
      const Duration(seconds: 4),
      (timer) async {
        if (Get.currentRoute != currentPage) {
          return timer.cancel();
        }
        if (paymentResponse != null) {
          debugPrint('Buscando dados d o pagamento');
          await getSchedulePaymentDetail(paymentResponse.paymentId!);
          if (scheduleDetails != null) {
            debugPrint('A venda está: ${scheduleDetails!.isPaid!}');
            if (scheduleDetails!.isPaid!) {
              final paied = paymentResponse;
              paied.paymentConfirmed = true;
              getSchedulePaymentDetail(paymentResponse.paymentId!);
              Get.toNamed(Routes.scheduleConclusion);
              update();
              timer.cancel();
            }
          }
        }
      },
    );
  }

  Future<void> getInvoicesPaymentDetail(String paymentId) async {
    setLoading(getPaymentDetails, true);
    try {
      final result =
          await _repository.getInvoicePaymentDetail(paymentId: paymentId);

      if (result.data != null) {
        paymentDetails = result.data!;
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading(getPaymentDetails, false);
  }

  Future<void> getSchedulePaymentDetail(String paymentId) async {
    setLoading(getPaymentDetails, true);
    try {
      final result =
          await _repository.getSchedulePaymentDetail(paymentId: paymentId);

      if (result.data != null) {
        scheduleDetails = result.data!;
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading(getPaymentDetails, false);
  }
}
