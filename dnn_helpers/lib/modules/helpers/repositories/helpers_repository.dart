import 'package:dnn_core/all_exports.dart';
import 'package:dnn_helpers/dnn_helpers.dart';

abstract class IHelpersRepository {
  Future<HttpResponse<HelperResponse>> getHelpers();
}

class HelpersRepository implements IHelpersRepository {
  final HttpManager _httpManager;

  HelpersRepository(this._httpManager);

  @override
  Future<HttpResponse<HelperResponse>> getHelpers() async {
    return await _httpManager.request(
      path: '/api/Helpers',
      method: HttpMethods.get,
      parser: (data) => HelperResponse.fromJson(data),
    );
  }
}
