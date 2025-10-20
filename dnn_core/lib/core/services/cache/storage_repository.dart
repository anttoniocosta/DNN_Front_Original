import 'dart:convert';

import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/dnn_dependencies.dart';
import 'package:dnn_dependencies/get_export.dart';

abstract class StorageKeys {
  static String firebaseToken = 'firebaseToken';
  static String uGuuid = 'user_guuid';
  static String gateways = 'gateways';
  static String theme = 'theme';
  static String url = 'url';
  static String socket = 'socket';

  static String userData = 'user_data';
  static String CART_ID = 'CART_ID';
  static String ORDER_ID = 'ORDER_ID';
  static String GATEWAY_ID = 'GATEWAY_ID';
  static String PAYMENT_CICLE = 'PAYMENT_CICLE';
  static String PAYMENT_IDS = 'PAYMENT_IDS';
  static String TOTAL_PRICE = 'TOTAL_PRICE';
  static String USE_TERMS_ID = 'USE_TERMS_ID';
  static String CART_OPEN = 'CART_OPEN';
  static String FB_TOKEN = 'FB_TOKEN';
  static String TOKEN = 'TOKEN';
  static String PAY_TERMS = 'PAY_TERMS';
  static String PLAN_ID = 'PLAN_ID';
  static String SCHEDULE_CONSULT_ID = 'SCHEDULE_CONSULT_ID';
  static String IS_ANOTHER_PATIENT = 'IS_ANOTHER_PATIENT';
  static String SAVE_ACCOUNT_FOR_SCHEDULE = 'SAVE_ACCOUNT_FOR_SCHEDULE';
}

class StorageRepository extends GetxService {
  static const _storage = FlutterSecureStorage();

  /// [BASE_USAGE] **************
  Future<void> saveLocalData(
      {required String key, required String data}) async {
    await _storage.write(key: key, value: data);
  }

  Future<String?> getLocalData({required String key}) async {
    return await _storage.read(key: key);
  }

  Future<void> removeLocalData({required String key}) async {
    await _storage.delete(key: key);
  }

  ///[ACCOUNT] ****************************
  Future<void> saveAccount(AccountResponseData? userData) async {
    await saveLocalData(
        key: StorageKeys.userData, data: jsonEncode(userData?.toJson()));
  }

  Future<AccountResponseData?> getAccount() async {
    try {
      final data = await storage.getLocalData(key: StorageKeys.userData);
      if (data != null)
        return AccountResponseData.fromJson(jsonDecode(data));
      else
        return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> removeAccount() async {
    await removeLocalData(key: StorageKeys.userData);
  }

  ///[TOKEN] ****************************

  Future<void> setToken(String token) async {
    await saveLocalData(key: StorageKeys.TOKEN, data: token);
  }

  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null;
  }

  Future<String?> getToken() async {
    try {
      return await getLocalData(key: StorageKeys.TOKEN);
    } catch (e) {
      return null;
    }
  }

  Future<void> removeToken() async {
    await removeLocalData(key: StorageKeys.TOKEN);
  }

  ///[GUUID] ****************************
  Future<String?> getGUUID() async {
    return await getLocalData(key: StorageKeys.uGuuid);
  }

  ///[GATEWAY_ID] ****************************
  Future<void> setGatewayId(int id) async {
    await saveLocalData(key: StorageKeys.GATEWAY_ID, data: id.toString());
  }

  Future<int?> getGatewayId() async {
    final gateway = await getLocalData(key: StorageKeys.GATEWAY_ID);
    if (gateway != null) return int.parse(gateway);
    return null;
  }

  Future<void> removeGatewayId() async {
    await removeLocalData(key: StorageKeys.GATEWAY_ID);
  }

  ///[PAYMENT_CICLE] ****************************
  Future<void> setPaymentCicle(int id) async {
    await saveLocalData(key: StorageKeys.PAYMENT_CICLE, data: id.toString());
  }

  Future<int?> getPaymentCicle() async {
    final payment = await getLocalData(key: StorageKeys.PAYMENT_CICLE);
    return int.parse(payment!);
  }

  Future<void> removePaymentCicle() async {
    await removeLocalData(key: StorageKeys.PAYMENT_CICLE);
  }

  ///[USE_TERMS] ****************************
  void saveUseTerms(int id) {
    saveLocalData(key: StorageKeys.USE_TERMS_ID, data: id.toString());
  }

  Future<int?> getUseTerms() async {
    final id = await getLocalData(key: StorageKeys.USE_TERMS_ID);
    if (id != null) return int.parse(id);
    return null;
  }

  Future<void> removeUseTerms() async {
    await removeLocalData(key: StorageKeys.USE_TERMS_ID);
  }

  ///[ORDER_ID] ****************************
  void saveOrderId(String id) {
    saveLocalData(key: StorageKeys.ORDER_ID, data: id);
  }

  Future<String?> getOrderId() async {
    return await getLocalData(key: StorageKeys.ORDER_ID);
  }

  Future<void> removeOrderId() async {
    await removeLocalData(key: StorageKeys.ORDER_ID);
  }

  ///[CART_ID] ****************************
  void saveCartId(String id) {
    saveLocalData(key: StorageKeys.CART_ID, data: id);
  }

  Future<String?> getCartId() async {
    return await getLocalData(key: StorageKeys.CART_ID);
  }

  Future<void> removeCartId() async {
    await removeLocalData(key: StorageKeys.CART_ID);
  }

  ///[PAYMENT_IDS] ****************************
  Future<void> saveGetPaymentIds(List<String> ids) async {
    await saveLocalData(key: StorageKeys.PAYMENT_IDS, data: jsonEncode(ids));
  }

  Future<List<String>?> getGetPaymentIds() async {
    final data = await getLocalData(key: StorageKeys.PAYMENT_IDS);
    if (data == null) return <String>[];
    return json.decode(data).cast<String>();
  }

  Future<void> removePaymentIds() async {
    await removeLocalData(key: StorageKeys.PAYMENT_IDS);
  }

  ///[TOTAL_PRICE] ****************************
  Future<void> setTotalPrice(double price) async {
    await saveLocalData(key: StorageKeys.TOTAL_PRICE, data: price.toString());
  }

  Future<double> getTotalPrice() async {
    final stringPrince = await getLocalData(key: StorageKeys.TOTAL_PRICE);
    return double.parse(stringPrince!);
  }

  ///[GATEWAY_LIST]*****************************************************
  Future<void> saveGatewayList(List<GatewayDataModel> gateways) async {
    await saveLocalData(key: StorageKeys.gateways, data: jsonEncode(gateways));
  }

  Future<List<GatewayDataModel>> getGatewayList() async {
    final data = await getLocalData(key: StorageKeys.gateways);
    return (jsonDecode(data!) as List)
        .map((e) => GatewayDataModel.fromJson(e))
        .toList();
  }

  ///[PAY_TERMS]*****************************************************
  void savePayTerm(String text) {
    saveLocalData(key: StorageKeys.PAY_TERMS, data: text);
  }

  Future<String?> getPayTerm() async {
    return await getLocalData(key: StorageKeys.PAY_TERMS);
  }

  Future<void> removePayTerm() async {
    await removeLocalData(key: StorageKeys.PAY_TERMS);
  }

  /// [PLAN_ID] *****************************************************
  void savePlanId(String text) {
    saveLocalData(key: StorageKeys.PLAN_ID, data: text);
  }

  Future<String?> getPlanId() async {
    return await getLocalData(key: StorageKeys.PLAN_ID);
  }

  /// [SCHEDULE_CONSULT_ID] *****************************************************
  void saveScheduleConsultId(String text) {
    saveLocalData(key: StorageKeys.SCHEDULE_CONSULT_ID, data: text);
  }

  Future<String?> getScheduleConsultId() async {
    return await getLocalData(key: StorageKeys.SCHEDULE_CONSULT_ID);
  }

  Future<void> removeScheduleConsultId() async {
    await removeLocalData(key: StorageKeys.SCHEDULE_CONSULT_ID);
  }

  /// [IS_ANOTHER_PATIENT] *****************************************************
  void saveIsAnotherPatient(bool text) {
    saveLocalData(key: StorageKeys.IS_ANOTHER_PATIENT, data: text.toString());
  }

  Future<bool?> getIsAnotherPatient() async {
    final boleano = await getLocalData(key: StorageKeys.IS_ANOTHER_PATIENT);
    return boleano == 'true' ? true : false;
  }

  Future<void> removeIsAnotherPatient() async {
    await removeLocalData(key: StorageKeys.IS_ANOTHER_PATIENT);
  }

  /// [SAVE_ACCOUNT_FOR_SCHEDULE] *****************************************************
  void saveAccountForSchedule(AccountRequestModel text) {
    saveLocalData(
        key: StorageKeys.SAVE_ACCOUNT_FOR_SCHEDULE,
        data: jsonEncode(text.toJson()));
  }

  Future<AccountRequestModel?> getAccountForSchedule() async {
    final data = await getLocalData(key: StorageKeys.SAVE_ACCOUNT_FOR_SCHEDULE);
    if (data != null) return AccountRequestModel.fromJson(jsonDecode(data));
    return null;
  }

  Future<void> removeAccountForSchedule() async {
    await removeLocalData(key: StorageKeys.SAVE_ACCOUNT_FOR_SCHEDULE);
  }
}
