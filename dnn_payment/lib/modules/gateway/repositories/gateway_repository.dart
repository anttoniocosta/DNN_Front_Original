import 'package:dnn_core/all_exports.dart';

abstract class IGatewayRepository {
  Future<HttpResponse<GatewayResponse>> getAllGateways();
}

class GatewayRepository implements IGatewayRepository {
  final HttpManager _httpManager;

  GatewayRepository(this._httpManager);

  @override
  Future<HttpResponse<GatewayResponse>> getAllGateways() async {
    return await _httpManager.request(
      path: '/api/Gateway',
      method: HttpMethods.get,
      parser: (data) => GatewayResponse.fromJson(data),
    );
  }
}
