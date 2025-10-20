import 'package:dnn_core/providers/mercadopago/card/card_repository.dart';
import 'package:dnn_core/providers/mercadopago/client/client_repository.dart';
import 'package:dnn_core/providers/mercadopago/payment/payment_repository.dart';
import 'package:dnn_core/providers/mercadopago/subscriptions/subscriptions_repository.dart';

class MercadoPago {
  final String acessToken;
  final String publicKey;
  final String applicationId;
  final String notificationUrl;

  late final CardRepository card;
  late final ClientRepository client;
  late final PaymentRepository payment;
  late final SubscriptionsRepository subscriptions;

  MercadoPago(
      {required this.acessToken,
      required this.publicKey,
      required this.applicationId,
      required this.notificationUrl}) {
    card = CardRepository(acessToken: acessToken);
    client = ClientRepository(acessToken: acessToken);
    payment = PaymentRepository(
        acessToken: acessToken, notificationUrl: notificationUrl);
    subscriptions = SubscriptionsRepository(
        acessToken: acessToken, notificationUrl: notificationUrl);
  }
}
