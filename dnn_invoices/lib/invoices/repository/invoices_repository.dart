import 'package:dnn_core/core/export.dart';
import 'package:dnn_core/modules/export.dart';

abstract class IInvoicesRepository {
  Future<HttpResponse<List<InvoiceResponseModel>>> getInvoices({bool? force});
  Future<HttpResponse<List<InvoiceServiceModel>>> getInvoicesServices();
  Future<HttpResponse<InvoicePaymentDetailsModel>> getInvoicePaymentDetail(
      {required String paymentId});
  Future<HttpResponse<List<InvoicePaymentDetailsModel>>> getInvoiceOrder(
      {required String orderId});
  Future<HttpResponse<bool>> cancelInvoice({required String paymentId});
}

class InvoicesRepository implements IInvoicesRepository {
  final HttpManager _httpManager;
  InvoicesRepository(this._httpManager);

  @override
  Future<HttpResponse<List<InvoiceResponseModel>>> getInvoices(
      {bool? force}) async {
    return await _httpManager.request(
      path: '/api/v2/invoices${force == true ? "?force=true" : ""}',
      method: HttpMethods.get,
      parser: (data) {
        if (data['data'] is List) {
          return (data['data'] as List<dynamic>)
              .map((e) => InvoiceResponseModel.fromJson(e))
              .toList();
        } else {
          throw Exception('Erro ao recuperar as faturas');
        }
      },
    );
  }

  @override
  Future<HttpResponse<List<InvoiceServiceModel>>> getInvoicesServices() async {
    return await _httpManager.request(
      path: '/api/v2/invoices/services',
      method: HttpMethods.get,
      parser: (data) {
        if (data is List) {
          return (data).map((e) => InvoiceServiceModel.fromJson(e)).toList();
        } else {
          throw Exception(
              'Problemas para recuperar os dados de histórico de atendimentos.');
        }
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
  Future<HttpResponse<List<InvoicePaymentDetailsModel>>> getInvoiceOrder(
      {required String orderId}) async {
    return await _httpManager.request(
      path: '/api/v2/invoices/$orderId',
      method: HttpMethods.get,
      parser: (data) {
        if (data['data'] is List) {
          return (data['data'] as List<dynamic>)
              .map((e) => InvoicePaymentDetailsModel.fromJson(e))
              .toList();
        } else {
          throw Exception('Erro ao recuperar as faturas');
        }
      },
    );
  }

  @override
  Future<HttpResponse<bool>> cancelInvoice({required String paymentId}) async {
    return await _httpManager.request(
      path: '/api/v2/invoices/$paymentId',
      method: HttpMethods.delete,
      parser: (data) => true,
    );
  }
}
