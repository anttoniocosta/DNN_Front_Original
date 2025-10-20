import 'dart:convert';

import 'package:dnn_core/providers/gerencianet/global_gn.dart';
import 'package:dnn_core/providers/gerencianet/models/gn_config.dart';
import 'package:dnn_core/providers/gerencianet/models/gn_credit_card.dart';
import 'package:dnn_core/providers/gerencianet/models/gn_payment_token.dart';
import 'package:dnn_core/providers/gerencianet/rsa.dart';
import 'package:http/http.dart' as http;

class GNApi {
  late GNConfig config;
  late String baseUrl;
  late String tokenizerUrl;
  late Map<String, String> headers;

  GNApi({required this.config}) {
    baseUrl = config.isSandbox
        ? GNConstants.baseUrlSandbox
        : GNConstants.baseUrlProduction;
    tokenizerUrl = config.isSandbox
        ? GNConstants.baseUrlSandbox
        : GNConstants.tokenizerUrl;
    headers = {'account-code': config.accountCode};
  }

  Future<GNPaymentToken?> retrievePaymentToken(GNCreditCard cc) async {
    final salt = await _salt;
    final pubKey = await _publicKey;
    cc.salt = salt;
    final encryptedCard = RSACustom.encrypt(cc.toJson(), pubKey);
    var url = Uri.parse("$tokenizerUrl/card");
    http.Response tokenResp = await http.post(
      url,
      headers: {
        "account-code": config.accountCode,
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {"data": encryptedCard},
    );
    if (tokenResp.body.isEmpty) return null;

    return GNPaymentToken.fromJson(jsonDecode(tokenResp.body));
  }

  Future<String> get _salt async {
    if (config.isSandbox) return "";
    var url = Uri.parse("$tokenizerUrl/salt");
    http.Response saltResp = await http.get(url, headers: headers);
    if (saltResp.body.isEmpty) return "";
    return jsonDecode(saltResp.body)["data"];
  }

  Future<String> get _publicKey async {
    var url = Uri.parse(baseUrl + GNConstants.routePublicKey);
    http.Response pubKeyResponse = await http.get(url, headers: headers);
    if (pubKeyResponse.body.isEmpty) return "";
    return jsonDecode(pubKeyResponse.body)["data"];
  }
}
