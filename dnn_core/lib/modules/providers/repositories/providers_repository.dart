import 'package:dnn_core/all_exports.dart';

abstract class IProvidersRepository {
  Future<HttpResponse<AddressByZipcodeResponse>> getUserAddressByCep({
    required String cep,
  });

  Future<HttpResponse<AccountByDocumentResponse>> getPersonInfosByDocument({
    required String document,
  });

  Future<HttpResponse<RapidocResponse>> getCallUrl({
    required String contractId,
    required String personId,
  });

  Future<HttpResponse<List<InstallmentsResponse>>> getGnInstallments({
    required String brand,
    required double total,
  });
}

class ProvidersRepository implements IProvidersRepository {
  final HttpManager _httpManager;

  ProvidersRepository(this._httpManager);

  @override
  Future<HttpResponse<AddressByZipcodeResponse>> getUserAddressByCep({
    required String cep,
  }) async {
    return await _httpManager.request(
      path: '/api/Providers/AddressByZipCode/$cep',
      method: HttpMethods.get,
      parser: (data) => AddressByZipcodeResponse.fromJson(data),
    );
  }

  @override
  Future<HttpResponse<AccountByDocumentResponse>> getPersonInfosByDocument({
    required String document,
  }) async {
    return await _httpManager.request(
      path: '/api/Providers/PersonInfoByDocument/$document',
      method: HttpMethods.get,
      parser: (data) => AccountByDocumentResponse.fromJson(data),
    );
  }

  @override
  Future<HttpResponse<RapidocResponse>> getCallUrl({
    required String contractId,
    required String personId,
  }) async {
    return await _httpManager.request(
      path: '/api/Providers/rapidoc/request-service/$contractId/$personId',
      method: HttpMethods.get,
      parser: (data) => RapidocResponse.fromJson(data),
    );
  }

  @override
  Future<HttpResponse<List<InstallmentsResponse>>> getGnInstallments({
    required String brand,
    required double total,
  }) async {
    return await _httpManager.request(
      path: '/api/Providers/gn/installments',
      method: HttpMethods.post,
      body: {'brand': brand, 'total': total},
      parser: (data) {
        if (data['data']['installments'] is List) {
          return (data['data']['installments'] as List<dynamic>)
              .map((e) => InstallmentsResponse.fromJson(e))
              .toList();
        } else {
          throw Exception('');
        }
      },
    );
  }
}
