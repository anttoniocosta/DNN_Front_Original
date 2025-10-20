import 'package:dnn_core/all_exports.dart';

abstract class ICardRepository {
  Future<HttpResponse<List<CardResponse>>> getListCards();

  Future<HttpResponse<String>> addCreditCard({
    required CardResponse model,
  });

  Future<HttpResponse<String>> removeCreditCard({
    required String id,
  });
}

class CardRepository implements ICardRepository {
  final HttpManager _httpManager;

  CardRepository(this._httpManager);

  @override
  Future<HttpResponse<String>> addCreditCard({
    required CardResponse model,
  }) async {
    return await _httpManager.request(
      path: '/api/Account/cards',
      method: HttpMethods.post,
      body: model.toJson(),
      parser: (data) => data['message'],
    );
  }

  @override
  Future<HttpResponse<List<CardResponse>>> getListCards() async {
    return await _httpManager.request(
      path: '/api/Account/cards',
      method: HttpMethods.get,
      parser: (data) {
        if (data is List) {
          // ignore: unnecessary_cast
          return (data as List<dynamic>)
              .map((e) => CardResponse.fromJson(e))
              .toList();
        } else {
          throw Exception("Houve um erro ao obter a lista de cartões");
        }
      },
    );
  }

  @override
  Future<HttpResponse<String>> removeCreditCard({
    required String id,
  }) async {
    return await _httpManager.request(
      path: '/api/Account/cards/$id',
      method: HttpMethods.delete,
      parser: (data) => data['message'],
    );
  }
}
