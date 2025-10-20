import 'package:dnn_core/all_exports.dart';
import 'package:dnn_pages/dnn_pages.dart';

abstract class IPagesRepository {
  Future<HttpResponse<PagesResponse>> getPages();
}

class PagesRepository implements IPagesRepository {
  final HttpManager _httpManager;

  PagesRepository(this._httpManager);

  @override
  Future<HttpResponse<PagesResponse>> getPages() async {
    return await _httpManager.request(
      path: '/api/Pages',
      method: HttpMethods.get,
      parser: (data) => PagesResponse.fromJson(data),
    );
  }
}
