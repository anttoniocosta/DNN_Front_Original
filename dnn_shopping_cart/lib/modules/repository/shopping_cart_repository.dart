import 'package:dnn_core/all_exports.dart';

abstract class IShoppingCartRepository {
  Future<HttpResponse<GetShoppingCartResponse>> getShoppingCart({
    required String userGuuid,
  });
  Future<HttpResponse<ShoppingCartItemsResponse>> getShoppingCartItems({
    required String userGuuid,
  });
  Future<HttpResponse<ShoppingCartPersonsResponse>> getShoppingCartPersons({
    required String userGuuid,
  });
  Future<HttpResponse<ShoppingCartItemsResponse>> addShoppingCart({
    required AddShoppingCartModel cartModel,
  });
  Future<HttpResponse<String>> addDependentCart({
    required AddShoppingDependent dependentModel,
  });
  Future<HttpResponse<bool>> deleteShoppingCart({
    required String cartId,
  });
  Future<HttpResponse<bool>> deleteShoppingCartPerson({
    required DeleteShoppingCartPerson deleteModel,
  });
  Future<HttpResponse<bool>> deleteShoppingCartPlan({
    required DeleteShoppingCartPlan deleteModel,
  });
}

class ShoppingCartRepository implements IShoppingCartRepository {
  final HttpManager _httpManager;
  ShoppingCartRepository(this._httpManager);

  final String pathUrl = '/api/v2/ShoppingCart';

  @override
  Future<HttpResponse<GetShoppingCartResponse>> getShoppingCart({
    required String userGuuid,
  }) async {
    return await _httpManager.request(
      path: '$pathUrl/$userGuuid',
      method: HttpMethods.get,
      parser: (data) => GetShoppingCartResponse.fromJson(data),
    );
  }

  @override
  Future<HttpResponse<ShoppingCartPersonsResponse>> getShoppingCartPersons(
      {required String userGuuid}) async {
    return await _httpManager.request(
      path: '$pathUrl/persons/$userGuuid',
      method: HttpMethods.get,
      parser: (data) => ShoppingCartPersonsResponse.fromJson(data['data']),
    );
  }

  @override
  Future<HttpResponse<ShoppingCartItemsResponse>> getShoppingCartItems(
      {required String userGuuid}) async {
    return await _httpManager.request(
      path: '$pathUrl/items/$userGuuid',
      method: HttpMethods.get,
      parser: (data) => ShoppingCartItemsResponse.fromJson(data['data']),
    );
  }

  @override
  Future<HttpResponse<bool>> deleteShoppingCart(
      {required String cartId}) async {
    return await _httpManager.request(
      path: '$pathUrl/$cartId',
      method: HttpMethods.delete,
      parser: (data) => true,
    );
  }

  @override
  Future<HttpResponse<bool>> deleteShoppingCartPerson(
      {required DeleteShoppingCartPerson deleteModel}) async {
    return await _httpManager.request(
      path: '$pathUrl/person',
      method: HttpMethods.delete,
      body: deleteModel.toJson(),
      parser: (data) => true,
    );
  }

  @override
  Future<HttpResponse<bool>> deleteShoppingCartPlan(
      {required DeleteShoppingCartPlan deleteModel}) async {
    return await _httpManager.request(
      path: '$pathUrl/plan',
      method: HttpMethods.delete,
      body: deleteModel.toJson(),
      parser: (data) => true,
    );
  }

  @override
  Future<HttpResponse<String>> addDependentCart(
      {required AddShoppingDependent dependentModel}) async {
    return await _httpManager.request<String>(
      path: '$pathUrl/dependente/add',
      method: HttpMethods.post,
      body: dependentModel.toJson(),
      parser: (data) {
        return data['dependentId'];
      },
    );
  }

  @override
  Future<HttpResponse<ShoppingCartItemsResponse>> addShoppingCart(
      {required AddShoppingCartModel cartModel}) async {
    return await _httpManager.request<ShoppingCartItemsResponse>(
      path: pathUrl,
      method: HttpMethods.post,
      body: cartModel.toJson(),
      parser: (data) {
        return ShoppingCartItemsResponse.fromJson(data['data']);
      },
    );
  }
}
