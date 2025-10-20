import 'package:dnn_core/core/services/http/http_manager.dart';
import 'package:dnn_core/core/services/http/http_response.dart';
import 'package:dnn_offers/modules/offers/export.dart';

abstract class IOffersRepository {
  Future<HttpResponse<OffersResponseModel>> getOffers();
  Future<HttpResponse<String>> getRedeParceira();
}

class OffersRepository implements IOffersRepository {
  final HttpManager _httpManager;
  OffersRepository(this._httpManager);

  @override
  Future<HttpResponse<OffersResponseModel>> getOffers() async {
    return await _httpManager.request(
      path: '/api/v2/Offers',
      method: HttpMethods.get,
      parser: (data) => OffersResponseModel.fromJson(data),
    );
  }

  @override
  Future<HttpResponse<String>> getRedeParceira() async {
    return await _httpManager.request(
      path: '/api/Providers/redeparceria/offers',
      method: HttpMethods.get,
      parser: (data) => data['link'],
    );
  }
}
