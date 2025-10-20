import 'package:dnn_core/all_exports.dart';

abstract class IStarAppointmentRepository {
  Future<HttpResponse<bool>> getPermission();
  Future<HttpResponse<List<InvoicePersonModel>>> getDependents(
      {bool? forceUpdate = false});
  Future<HttpResponse<RapidocModel>> requestService({required String personId});
}

class StarAppointmentRepository implements IStarAppointmentRepository {
  final HttpManager _httpManager;
  StarAppointmentRepository(this._httpManager);

  @override
  Future<HttpResponse<bool>> getPermission() async {
    return await _httpManager.request(
      path: '/api/v2/permissions/generalclinic',
      method: HttpMethods.get,
      parser: (data) => true,
    );
  }

  @override
  Future<HttpResponse<List<InvoicePersonModel>>> getDependents(
      {bool? forceUpdate = false}) async {
    return await _httpManager.request(
      path: '/api/v2/permissions/dependents?force=$forceUpdate',
      method: HttpMethods.get,
      parser: (data) {
        if (data is List) {
          return data.map((e) => InvoicePersonModel.fromJson(e)).toList();
        } else {
          throw Exception("Houve um erro ao trazer os dependentes.");
        }
      },
    );
  }

  @override
  Future<HttpResponse<RapidocModel>> requestService(
      {required String personId}) async {
    return await _httpManager.request(
      path: '/api/Providers/rapidoc/request-service/$personId',
      method: HttpMethods.get,
      parser: (data) {
        return RapidocModel.fromJson(data['data']);
      },
    );
  }
}
