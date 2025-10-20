import 'package:dnn_core/all_exports.dart';
import 'package:dnn_setup/modules/app_version/export.dart';

abstract class IAppVersionRepository {
  Future<HttpResponse<AppVersionModel>> getAppVersion(
      {required String packageName});
}

class AppVersionRepository implements IAppVersionRepository {
  final HttpManager _httpManager;
  AppVersionRepository(this._httpManager);

  @override
  Future<HttpResponse<AppVersionModel>> getAppVersion(
      {required String packageName}) async {
    return await _httpManager.request<AppVersionModel>(
      path: '/api/v1/AppVersion/version?package=$packageName',
      method: HttpMethods.get,
      parser: (data) => AppVersionModel.fromJson(data),
    );
  }
}
