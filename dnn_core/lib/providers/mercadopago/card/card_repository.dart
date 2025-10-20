import 'package:dnn_core/providers/mercadopago/card/card_model.dart';
import 'package:dnn_core/providers/mercadopago/card/installment_model.dart';
import 'package:dnn_core/providers/mercadopago/request_repository.dart';

class CardRepository {
  final request = Request();
  final String acessToken;

  CardRepository({required this.acessToken});

  ///Retorna as informações de um cartão através de seu [id]
  Future<CardMp?> get({required String id}) async {
    try {
      var result =
          await request.get(path: "v1/card_tokens/$id", acessToken: acessToken);

      final card = CardMp.fromJson(result, options: true);

      return card;
    } catch (e) {
      return throw e;
    }
  }

  ///Essa função gera o token do cartão.
  ///
  ///Para saber mais detalhes do tipo de pagamento e id, acesse:
  ///https://www.mercadopago.com.br/developers/pt/guides/resources/localization/payment-methods
  Future<String> token(
      {required String cardName,
      required String cpf,
      required String cardNumber,
      required int expirationMoth,
      required int expirationYear,
      required String securityCode,
      required String issuer}) async {
    try {
      final card = {
        'cardholder': {
          'identification': {
            'number': cpf,
            'type': 'CPF',
          },
          'name': cardName,
        },
        'cardNumber': cardNumber,
        'expirationMonth': expirationMoth,
        'expirationYear': expirationYear,
        'securityCode': securityCode,
        'issuer': issuer
      };

      final result = await request.post(
          path: 'v1/card_tokens', acessToken: acessToken, data: card);
      final id = result['id'];

      return id;
    } catch (e) {
      return throw e;
    }
  }

  ///Essa função gera um token de um cartão ja salvo do client através do [cardId] id do cartão salvo
  ///e do [securityCode] código de segurança do cartão.
  Future<String> tokenWithCard(
      {required String cardId, required String securityCode}) async {
    try {
      final result = await request.post(
          path: 'v1/card_tokens',
          acessToken: acessToken,
          data: {'cardId': cardId, 'securityCode': securityCode});

      return result['id'];
    } catch (e) {
      return throw e;
    }
  }

  /// Retorna as parcelas possíveis pelo valor informado já
  /// com o valor total com juros
  Future<InstallmentModel> getInstallments({
    required double amount,
    required String cardNumber,
  }) async {
    try {
      final params = {
        'locale': 'pt-BR',
        'amount': amount.toStringAsFixed(2),
        'bin': cardNumber.replaceAll(' ', '').substring(0, 6),
      };

      final resp = await request.get(
          path: 'v1/payment_methods/installments',
          data: params,
          acessToken: acessToken);

      return InstallmentModel.fromJson(resp[0]);
    } catch (e) {
      return throw e;
    }
  }

  /// Retorna o nome do emissor do cartao atraves do número informado: 'master', 'visa' etc...
  Future<String?> getIssuerId({required String cardNumber}) async {
    String? result;
    try {
      final params = Uri(queryParameters: {
        'bins': cardNumber.replaceAll(' ', '').substring(0, 8)
      }).query;

      final resp = await request.get(
          path: 'v1/payment_methods/search?$params', acessToken: acessToken);

      result = resp['results'][0]['id'];
    } catch (e) {
      return throw e;
    }
    return result;
  }
}
