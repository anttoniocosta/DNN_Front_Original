import 'package:dnn_core/all_exports.dart';

abstract class IQARepository {
  Future<HttpResponse<ScenariosResponse>> getScenarios();
  Future<HttpResponse<bool>> getHasQA();
}

class QARepository implements IQARepository {
  final HttpManager _httpManager;
  QARepository(this._httpManager);

  @override
  Future<HttpResponse<ScenariosResponse>> getScenarios() async {
    return await _httpManager.request(
      path: '/api/QA/scenarios',
      method: HttpMethods.get,
      parser: (data) => ScenariosResponse.fromJson(data),
    );
  }

  @override
  Future<HttpResponse<bool>> getHasQA() async {
    return await _httpManager.request(
      path: '/api/QA/hasScenarios',
      method: HttpMethods.get,
      parser: (data) => data['hasQA'],
    );
  }
}
