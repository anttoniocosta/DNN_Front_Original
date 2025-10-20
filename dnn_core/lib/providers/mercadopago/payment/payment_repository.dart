import 'package:dnn_core/providers/mercadopago/extensions/mp_extensions.dart';
import 'package:dnn_core/providers/mercadopago/payment/methodspayment_model.dart';
import 'package:dnn_core/providers/mercadopago/payment/payment_model.dart';
import 'package:dnn_core/providers/mercadopago/request_repository.dart';

class PaymentRepository {
  final request = Request();
  final String acessToken;
  final String notificationUrl;
  PaymentRepository({required this.acessToken, required this.notificationUrl});

  Future<Payment> get({required String id}) async {
    try {
      final result =
          await request.get(path: "v1/payments/$id", acessToken: acessToken);
      final payment = Payment.fromJson(result);

      return payment;
    } catch (e) {
      return throw e;
    }
  }

  ///Retorna os métodos de pagamento disponíveis.
  Future<List<MethodsPayment>> paymentMethods() async {
    try {
      final result =
          await request.get(path: "v1/payment_methods", acessToken: acessToken);

      final methods = List<MethodsPayment>.from(
          result.map((metd) => MethodsPayment.fromJson(metd)).toList());
      return methods;
    } catch (e) {
      return throw e;
    }
  }

  ///Realiza o pagamento através do cartão de crédito.
  ///
  ///Se for passado como parametro [clientId], realiza o pagamento com as informações
  ///do cliente já salvas no mercado pago.
  ///
  ///Caso contrário, é obrigatório o preenchimento de todas as demais informações do cliente
  ///[email], [name], [docNumber].
  Future<Payment> creditCard(
      {String? clientId,
      required String tokenCard,
      required double amount,
      String? description,
      required String paymentMethodId,
      required String? externalReference,
      required int installments,
      String? issuer,
      String? name,
      String? email,
      String? docNumber}) async {
    try {
      final payer = clientId != null
          ? {'type': "customer", 'id': clientId}
          : {
              "email": email,
              "first_name": name!.split(' ').first,
              "last_name": name.split(' ').last,
              "identification": {"type": 'CPF', "number": docNumber},
            };

      final obj = {
        'notification_url': notificationUrl,
        'external_reference': externalReference,
        'transaction_amount': amount,
        'token': tokenCard,
        'description': description,
        'installments': installments,
        'payment_method_id': paymentMethodId,
        'issuer_id': issuer,
        'payer': payer,
      };

      final result = await request.post(
          path: 'v1/payments', acessToken: acessToken, data: obj);

      final payment = Payment.fromJson(result);
      return payment;
    } catch (e) {
      return throw e;
    }
  }

  ///Pagamento em boleto
  Future<Payment> ticket(
      {String? description,
      String? clientId,
      required String? externalReference,
      required double amount,
      required String name,
      required String email,
      required String docNumber}) async {
    DateTime now = DateTime.now();
    DateTime dateExpiration = now.add(Duration(days: 1));
    final payer = clientId != null
        ? {'type': "customer", 'id': clientId}
        : {
            "email": email,
            "first_name": name.split(' ').first,
            "last_name": name.split(' ').last,
            "identification": {"type": 'CPF', "number": docNumber},
          };

    var data = {
      'notification_url': notificationUrl,
      'external_reference': externalReference,
      "transaction_amount": amount,
      "description": description ?? "",
      "payment_method_id": 'bolbradesco',
      "payer": payer,
      "date_of_expiration": dateExpiration.toFormatMP(),
    };

    final result = await request.post(
        path: 'v1/payments', acessToken: acessToken, data: data);

    final ticket = Payment.fromJson(result, ticket: true);
    return ticket;
  }

  ///Pagamento através de PIX
  Future<Payment> pix(
      {String? description,
      String? clientId,
      required double amount,
      required String? externalReference,
      required String name,
      required String email,
      required String docNumber}) async {
    DateTime now = DateTime.now();
    DateTime dateExpiration = now.add(Duration(hours: 1));

    final payer = clientId != null
        ? {'type': "customer", 'id': clientId}
        : {
            "email": email,
            "first_name": name.split(' ').first,
            "last_name": name.split(' ').last,
            "identification": {"type": 'CPF', "number": docNumber},
          };

    final data = {
      'notification_url': notificationUrl,
      'external_reference': externalReference,
      "transaction_amount": amount,
      "description": description ?? "",
      "payment_method_id": 'pix',
      "payer": payer,
      "date_of_expiration": dateExpiration.toFormatMP(),
    };

    final result = await request.post(
        path: 'v1/payments', acessToken: acessToken, data: data);

    final pix = Payment.fromJson(result, pix: true);
    return pix;
  }
}
