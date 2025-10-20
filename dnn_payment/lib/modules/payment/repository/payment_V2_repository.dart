import 'dart:convert';
import 'dart:developer';

import 'package:dnn_core/all_exports.dart';

abstract class IPaymentV2Repository {
  Future<HttpResponse<PaymentResponseModel>> payment({
    required PaymentResquestModel payment,
  });

  Future<HttpResponse<PaymentResponseModel>> renewal({
    required PaymentResquestModel renewal,
  });

  Future<HttpResponse<ScheduleSuccessResponseModel>> schedule({
    required SchedulePaymentRequestModel schedule,
  });

  Future<HttpResponse<InvoicePaymentDetailsModel>> getInvoicePaymentDetail(
      {required String paymentId});
  Future<HttpResponse<SchedulePaymentDetailsModel>> getSchedulePaymentDetail(
      {required String paymentId});
}

class PaymentV2Repository implements IPaymentV2Repository {
  final HttpManager _httpManager;

  PaymentV2Repository(this._httpManager);

  @override
  Future<HttpResponse<PaymentResponseModel>> payment({
    required PaymentResquestModel payment,
  }) async {
    log(jsonEncode(payment.toJsonPay()));
    return await _httpManager.request<PaymentResponseModel>(
      path: '/api/v2/payment',
      method: HttpMethods.post,
      body: payment.toJsonPay(),
      parser: (data) {
        return PaymentResponseModel.fromJson(data);
      },
    );
  }

  @override
  Future<HttpResponse<PaymentResponseModel>> renewal({
    required PaymentResquestModel renewal,
  }) async {
    log(jsonEncode(renewal.toJsonRenewal()));
    return await _httpManager.request<PaymentResponseModel>(
      path: '/api/v2/payment/renewal',
      method: HttpMethods.post,
      body: renewal.toJsonRenewal(),
      parser: (data) {
        return PaymentResponseModel.fromJson(data);
      },
    );
  }

  @override
  Future<HttpResponse<InvoicePaymentDetailsModel>> getInvoicePaymentDetail(
      {required String paymentId}) async {
    return await _httpManager.request(
      path: '/api/v2/invoices/payment/$paymentId',
      method: HttpMethods.get,
      parser: (data) => InvoicePaymentDetailsModel.fromJson(data),
    );
  }

  @override
  Future<HttpResponse<SchedulePaymentDetailsModel>> getSchedulePaymentDetail(
      {required String paymentId}) async {
    return await _httpManager.request(
      path: '/api/v2/Schedule/payment/$paymentId',
      method: HttpMethods.get,
      parser: (data) => SchedulePaymentDetailsModel.fromJson(data),
    );
  }

  @override
  Future<HttpResponse<ScheduleSuccessResponseModel>> schedule({
    required SchedulePaymentRequestModel schedule,
  }) async {
    return await _httpManager.request(
      path: '/api/v2/Clinic/schedule/buy',
      method: HttpMethods.post,
      body: schedule.toJson(),
      parser: (data) => ScheduleSuccessResponseModel.fromJson(data),
    );
  }
}
