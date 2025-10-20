import 'package:dnn_core/all_exports.dart';
import 'package:dnn_core/core/utils/typedef/typedef.dart';
import 'package:dnn_core/models/register_login/login_provider_model.dart';

abstract class IAuthenticationRepository {
  Future<HttpResponse<AccountResponseModel>> signInUserAccount({
    required LoginModel loginModel,
  });

  Future<HttpResponse<bool>> updateUserPassword({
    required DataMap updatePasswordModel,
  });

  Future<HttpResponse<bool>> forgetPassword({required String login});

  Future<HttpResponse<AccountResponseModel>> signInUserProvider({
    required LoginProviderModel loginModel,
  });

  Future<HttpResponse<String>> getImpersonation();

  Future<HttpResponse<AccountResponseModel>> instanceChange({
    required InstancesRequestModel instance,
  });
}

class AuthenticationRepository implements IAuthenticationRepository {
  final HttpManager _httpManager;

  AuthenticationRepository(this._httpManager);

  @override
  Future<HttpResponse<bool>> forgetPassword({
    required String login,
  }) async {
    return await _httpManager.request(
      path: '/api/Auth/forget-password',
      method: HttpMethods.post,
      body: {'login': login},
      parser: (data) => true,
    );
  }

  @override
  Future<HttpResponse<AccountResponseModel>> signInUserAccount({
    required LoginModel loginModel,
  }) async {
    return await _httpManager.request(
      path: switch (appContext.type) {
        AppTypeEnum.CLIENT => '/api/Auth',
        AppTypeEnum.SELLER => '/api/Auth/instance',
        AppTypeEnum.COMPANY => '/api/Auth/company',
        AppTypeEnum.CLINIC || AppTypeEnum.SPECIALIST => '/api/Auth/clinic',
        int() => '/api/Auth',
      },
      method: HttpMethods.post,
      headers: appContext.ctx != null ? {'context': appContext.ctx} : null,
      body: loginModel.toJson(),
      parser: (data) => AccountResponseModel.fromJson(data),
    );
  }

  @override
  Future<HttpResponse<AccountResponseModel>> signInUserProvider({
    required LoginProviderModel loginModel,
  }) async {
    return await _httpManager.request(
      path: '/api/Auth/provider',
      method: HttpMethods.post,
      body: loginModel.toJson(),
      parser: (data) => AccountResponseModel.fromJson(data),
    );
  }

  @override
  Future<HttpResponse<bool>> updateUserPassword({
    required DataMap updatePasswordModel,
  }) async {
    return await _httpManager.request(
      path: '/api/Auth/password-reset',
      method: HttpMethods.put,
      body: updatePasswordModel,
      parser: (data) => true,
    );
  }

  @override
  Future<HttpResponse<String>> getImpersonation() async {
    return await _httpManager.request(
      path: '/api/Auth/impersonation',
      method: HttpMethods.get,
      parser: (data) => data['code'],
    );
  }

  @override
  Future<HttpResponse<AccountResponseModel>> instanceChange(
      {required InstancesRequestModel instance}) async {
    return await _httpManager.request(
      path: '/api/Auth/instance/change',
      headers: appContext.ctx != null ? {'context': appContext.ctx} : null,
      method: HttpMethods.put,
      body: instance.toJson(),
      parser: (data) => AccountResponseModel.fromJson(data),
    );
  }
}
