library dnn_payment;

import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_payment/modules/card/export.dart';

import 'modules/payment/controllers/faturar_controller.dart';

export './modules/payment/export.dart';
export './modules/gateway/export.dart';
export './components/address_choice_widget.dart';
export './components/billet_actions.dart';
export './components/card_infos_for_resume.dart';
export './components/credit_card_info_partial.dart';
export './components/custom_card_tile.dart';
export './components/installment_info.dart';
export './components/installment_tile.dart';
export './components/abstract_card_widget.dart';
export './components/card_list_partial.dart';

final mercadoPagoController = Get.find<MercadoPagoController>();
final pixController = Get.find<PixController>();
final billetController = Get.find<BilletController>();
final creditCardController = Get.find<CreditCardController>();
final gatewayController = Get.find<GatewayController>();
final cardController = Get.find<CardController>();
final paymentDetailsController = Get.find<PaymentDetailsController>();
final faturarController = Get.find<FaturarController>();
