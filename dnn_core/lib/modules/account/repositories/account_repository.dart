import 'package:dnn_core/core/utils/typedef/typedef.dart';

import '../../../all_exports.dart';

abstract class IAccountRepository {
  Future<HttpResponse<AccountResponseModel>> createUserAccount({
    required AccountRequestModel account,
  });

  Future<HttpResponse<ClinicResponseModel>> createClinic({
    required CreateClinicParams params,
  });

  Future<HttpResponse<AccountDetailsResponse>> getAccountInfos();

  Future<HttpResponse<bool>> updateUserData({
    required UpdateUserInfosRequest account,
  });

  Future<HttpResponse<bool>> uploadUserPhoto({required DataMap formData});

  Future<HttpResponse<String>> sendPhoneForPincodeSMS({
    required String phoneNumber,
  });

  Future<HttpResponse<String>> phoneValidation({
    required String pinCode,
    required String phoneNumber,
  });
  Future<HttpResponse<List<CardResponse>>> getListCards();

  Future<HttpResponse<String>> addCreditCard({
    required CardResponse model,
  });

  Future<HttpResponse<String>> removeCreditCard({
    required String id,
  });

  Future<HttpResponse<List<MaritalStatusModel>>> getMaritalStatus();
}

class AccountRepository implements IAccountRepository {
  final HttpManager _httpManager;

  AccountRepository(this._httpManager);

  @override
  Future<HttpResponse<AccountResponseModel>> createUserAccount({
    required AccountRequestModel account,
  }) async {
    return await _httpManager.request(
      path: '/api/Account',
      method: HttpMethods.post,
      body: account.toJson(),
      headers: appContext.ctx != null ? {'context': appContext.ctx} : null,
      parser: (data) {
        return AccountResponseModel.fromJson(data);
      },
    );
  }

  @override
  Future<HttpResponse<ClinicResponseModel>> createClinic({
    required CreateClinicParams params,
  }) async {
    return await _httpManager.request(
      path: '/api/v2/Clinic',
      method: HttpMethods.post,
      body: params.toJson(),
      parser: (data) {
        return ClinicResponseModel.fromJson(data);
      },
    );
  }

  @override
  Future<HttpResponse<AccountDetailsResponse>> getAccountInfos() async {
    return await _httpManager.request(
      path: '/api/Account',
      method: HttpMethods.get,
      headers: appContext.ctx != null ? {'context': appContext.ctx} : null,
      parser: (data) => AccountDetailsResponse.fromJson(data),
    );
  }

  @override
  Future<HttpResponse<String>> sendPhoneForPincodeSMS({
    required String phoneNumber,
  }) async {
    return await _httpManager.request(
      path: '/api/Account/phone/send/$phoneNumber',
      method: HttpMethods.post,
      parser: (data) => data['message'],
    );
  }

  @override
  Future<HttpResponse<bool>> updateUserData({
    required UpdateUserInfosRequest account,
  }) async {
    return await _httpManager.request(
      path: '/api/Account',
      method: HttpMethods.put,
      body: account.toJson(),
      parser: (data) => true,
    );
  }

  @override
  Future<HttpResponse<bool>> uploadUserPhoto({
    required Map<String, dynamic> formData,
  }) async {
    return await _httpManager.request(
      path: 'pathi/Account/photo',
      method: HttpMethods.post,
      formData: formData,
      parser: (data) => true,
    );
  }

  @override
  Future<HttpResponse<String>> phoneValidation({
    required String pinCode,
    required String phoneNumber,
  }) async {
    return await _httpManager.request(
      path: '/api/Account/phone/validation',
      method: HttpMethods.post,
      body: {'phoneNumber': phoneNumber, 'pincode': pinCode},
      parser: (data) => data['message'],
    );
  }

  @override
  Future<HttpResponse<String>> addCreditCard({
    required CardResponse model,
  }) async {
    return await _httpManager.request(
      path: '/api/Account/cards',
      method: HttpMethods.post,
      body: model.toJson(),
      parser: (data) => data['message'],
    );
  }

  @override
  Future<HttpResponse<List<CardResponse>>> getListCards() async {
    return await _httpManager.request(
      path: '/api/Account/cards',
      method: HttpMethods.get,
      parser: (data) {
        if (data is List) {
          // ignore: unnecessary_cast
          return (data as List<dynamic>)
              .map((e) => CardResponse.fromJson(e))
              .toList();
        } else {
          throw Exception("Houve um erro ao obter a lista de cartões");
        }
      },
    );
  }

  @override
  Future<HttpResponse<String>> removeCreditCard({
    required String id,
  }) async {
    return await _httpManager.request(
      path: '/api/Account/cards/$id',
      method: HttpMethods.delete,
      parser: (data) => data['message'],
    );
  }

  @override
  Future<HttpResponse<List<MaritalStatusModel>>> getMaritalStatus() async {
    return await _httpManager.request(
      path: '/api/Account/maritalstatus',
      method: HttpMethods.get,
      parser: (data) {
        if (data is List) {
          return data.map((e) => MaritalStatusModel.fromJson(e)).toList();
        } else {
          throw Exception("Houve um erro ao obter a lista de cartões");
        }
      },
    );
  }
}
