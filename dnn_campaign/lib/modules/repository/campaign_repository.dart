import 'package:dnn_core/all_exports.dart';

abstract class ICampaignRepository {
  Future<HttpResponse<List<CampaignProductModel>>> getCampaigns();
  Future<HttpResponse<List<CampaignProductModel>>> getCampaignsV3();
  Future<HttpResponse<List<CampaignProductModel>>> getComplementsV3(
      {required String id});
  Future<HttpResponse<List<SellerLinkModel>>> getSellerLinks();
}

class CampaignRepository implements ICampaignRepository {
  final HttpManager _httpManager;
  CampaignRepository(this._httpManager);

  @override
  Future<HttpResponse<List<CampaignProductModel>>> getCampaigns() async {
    return _httpManager.request<List<CampaignProductModel>>(
      path: '/api/v2/Campaigns/mobile',
      method: HttpMethods.get,
      parser: (data) {
        if (data['data']['products'] is List) {
          List<CampaignProductModel> lista =
              (data['data']['products'] as List<dynamic>)
                  .map((e) => CampaignProductModel.fromJson(e))
                  .toList();
          return lista;
        } else {
          throw Exception('Erro ao trazer os produtos');
        }
      },
    );
  }

  @override
  Future<HttpResponse<List<CampaignProductModel>>> getCampaignsV3() async {
    return _httpManager.request<List<CampaignProductModel>>(
      path: '/api/v3/Campaigns/mobile',
      method: HttpMethods.get,
      parser: (data) {
        if (data['data']['products'] is List) {
          List<CampaignProductModel> lista =
              (data['data']['products'] as List<dynamic>)
                  .map((e) => CampaignProductModel.fromJson(e))
                  .toList();
          return lista;
        } else {
          throw Exception('Erro ao trazer os produtos');
        }
      },
    );
  }

  @override
  Future<HttpResponse<List<CampaignProductModel>>> getComplementsV3(
      {required String id}) async {
    return _httpManager.request<List<CampaignProductModel>>(
      path: '/api/v3/Campaigns/mobile/complements/$id',
      method: HttpMethods.get,
      parser: (data) {
        if (data is List) {
          List<CampaignProductModel> lista =
              (data).map((e) => CampaignProductModel.fromJson(e)).toList();
          return lista;
        } else {
          throw Exception('Erro ao trazer os produtos');
        }
      },
    );
  }

  @override
  Future<HttpResponse<List<SellerLinkModel>>> getSellerLinks() async {
    return _httpManager.request<List<SellerLinkModel>>(
      path: '/api/v2/Campaigns/links',
      method: HttpMethods.get,
      parser: (data) {
        if (data is List) {
          List<SellerLinkModel> lista =
              (data).map((e) => SellerLinkModel.fromJson(e)).toList();
          return lista;
        } else {
          throw Exception('Erro ao trazer os links de vendedor');
        }
      },
    );
  }
}
