import '../../../all_exports.dart';

abstract class IDnnRepository {
  Future<HttpResponse<DnnResponse>> getConfigs();
}

class DnnRepository implements IDnnRepository {
  final HttpManager _httpManager;
  DnnRepository(this._httpManager);

  @override
  Future<HttpResponse<DnnResponse>> getConfigs() async {
    return await _httpManager.request<DnnResponse>(
      path: '/api/Dnn',
      method: HttpMethods.get,
      parser: (data) => DnnResponse.fromJson(data),
    );
  }
}
