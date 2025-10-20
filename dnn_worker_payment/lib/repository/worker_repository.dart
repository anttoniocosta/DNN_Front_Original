import 'dart:convert';
import 'dart:developer';

import 'package:dnn_core/all_exports.dart';

abstract class IWorkerRepository {
  Future<HttpResponse<PaymentResponseModel>> renewal({
    required PaymentResquestModel renewal,
  });
  // Future<HttpResponse<PaymentResponseModel>> workerCards({
  //   required PaymentResquestModel renewal,
  // });
}

class WorkerRepository implements IWorkerRepository {
  final HttpManager _httpManager;

  WorkerRepository(this._httpManager);

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
}
