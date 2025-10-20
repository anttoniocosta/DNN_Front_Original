import 'package:dnn_core/all_exports.dart';
import 'package:dnn_use_terms/dnn_use_terms.dart';

abstract class IUseTermsRepository {
  Future<HttpResponse<UseTermsResponse>> getUseTerms();
}

class UseTermsRepository implements IUseTermsRepository {
  final HttpManager _httpManager;

  UseTermsRepository(this._httpManager);

  @override
  Future<HttpResponse<UseTermsResponse>> getUseTerms() async {
    return await _httpManager.request<UseTermsResponse>(
      path: '/api/UseTerms',
      method: HttpMethods.get,
      parser: (data) {
        return UseTermsResponse.fromJson(data);
      },
    );
  }
}
