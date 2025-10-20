import 'dart:convert';
import 'dart:developer';

import 'package:dnn_authentication/dnn_authentication.dart';
import 'package:dnn_core/all_exports.dart';
import 'package:dnn_core/core/jsons/json_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../providers/mercadopago/mercadopago_transparent.dart'
    as mercadopago;

enum Environment { Production, Hml, Tester, Local }

class DnnController extends GetxController {
  final IDnnRepository _repository;

  DnnController(this._repository);

  DnnResponse? dnnConfigs;

  bool get isSandboxMp => dnnConfigs!.mpProduction!;
  bool get isSandboxGn => dnnConfigs!.efiProduction!;
  String get apiUrl => setApiUrl();
  Environment currentEnvironment = Environment.Production;
  VoidCallback? onTapError;
  GNConfig get config => setGnConfig();
  mercadopago.MercadoPago get mercado => mercadoConfig();

  Map<String, String> urls = {
    'hml': 'https://hml-api.doutornanet.com.br',
    'prod': 'https://api.doutornanet.com.br',
    'tester': 'https://dev-api.doutornanet.com.br',
    'local': 'https://hml-api.doutornanet.com.br'
  };
  Map<String, String> socket = {
    'hml': 'https://hml-ws.doutornanet.com.br/pollHub',
    'prod': 'https://ws.doutornanet.com.br/pollHub',
    'tester': 'https://dev-ws.doutornanet.com.br/pollHub',
    'local': 'https://dev-ws.doutornanet.com.br/pollHub',
  };

  Future<void> getConfigsFromJson() async {
    final cacheResponse = await DnnResponse().getData();
    if (cacheResponse == null) {
      String jsonString = await rootBundle.loadString(JsonPath.dnn);

      Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

      final response = DnnResponse.fromJson(jsonResponse);
      dnnConfigs = response;
    } else {
      dnnConfigs = cacheResponse;
    }
  }

  Future<void> getConfigs() async {
    try {
      onTapError = null;
      await verifyConfigDnn();
      if (kReleaseMode)
        changeUrl(Environment.Production);
      else
        changeUrl(Environment.Hml);
    } catch (e) {
      onTapError = () async => await getConfigs();
      Get.offAllNamed(Routes.badInternet);
    }
  }

  Future<void> verifyConfigDnn() async {
    try {
      onTapError = null;
      // if (kReleaseMode) {
      //   final configData = await DnnResponse().getData();
      //   if (configData != null) {
      //     dnnConfigs = configData;
      //     onTapError = null;
      //     return;
      //   } else {
      //     final jsonData =
      //         DnnResponse.fromJson(await JsonCustom.load(path: JsonPath.dnn));
      //     await dbContext.addData(
      //       key: DatabaseModels.dnnResponse,
      //       data: jsonData,
      //       clearCurrentData: true,
      //     );
      //     dnnConfigs = jsonData;
      //     onTapError = null;
      //     return;
      //   }
      // }
      final result = await _repository.getConfigs();
      if (result.data != null) {
        result.data!.updateAt = DateTime.now();
        await dbContext.addData(
          key: DatabaseModels.dnnResponse,
          data: result.data,
          clearCurrentData: true,
        );
        dnnConfigs = result.data;
        onTapError = null;
      } else {
        onTapError = () async {
          await getConfigs();
        };
        Get.offAllNamed(Routes.badInternet);
      }
    } catch (e) {
      onTapError = () async {
        await getConfigs();
      };
      Get.offAllNamed(Routes.badInternet);
    }
  }

  setGnConfig() {
    return GNConfig(
      accountCode: dnnConfigs!.efiAccountNumber!,
      isSandbox: !isSandboxGn,
    );
  }

  getIsProduction() {
    switch (currentEnvironment) {
      case Environment.Production:
        return true;
      case Environment.Hml:
      case Environment.Tester:
      case Environment.Local:
        return false;
    }
  }

  Future<void> loadUrl() async {
    String? url =
        await storage.getLocalData(key: StorageKeys.url) ?? urls['prod'];
    if (url == urls['prod']) {
      currentEnvironment = Environment.Production;
    } else if (url == urls['hml']) {
      currentEnvironment = Environment.Hml;
    } else if (url == urls['local']) {
      currentEnvironment = Environment.Local;
    } else {
      currentEnvironment = Environment.Tester;
    }
    log(currentEnvironment.toString());
    setApiUrl();
    setSocketUrl();
  }

  Future<void> changeUrl(Environment newEnvironment) async {
    if (currentEnvironment != newEnvironment) {
      currentEnvironment = newEnvironment;
      await storage.saveLocalData(key: StorageKeys.url, data: setApiUrl());
      await storage.saveLocalData(
          key: StorageKeys.socket, data: setSocketUrl());

      await dbContext.deleteByKey(key: DatabaseModels.helperResponse);
      await dbContext.deleteByKey(key: DatabaseModels.learnMoreResponse);
      await dbContext.deleteByKey(key: DatabaseModels.pagesResponse);
      await dbContext.deleteByKey(key: DatabaseModels.planResponse);
      await dbContext.deleteByKey(key: DatabaseModels.segmentsResponse);
      await dbContext.deleteByKey(key: DatabaseModels.specialtyResponse);
      await dbContext.deleteByKey(key: DatabaseModels.useTermsResponse);
      await dbContext.deleteByKey(key: DatabaseModels.dnnResponse);

      log(currentEnvironment.toString());
      await getConfigs();
      navigationController.setIndex(NavigationTabs.home);
      authenticationController.signOut(() {
        navigationController.getUserLogged();
        navigationController.setIndex(NavigationTabs.home);
        Get.offAllNamed(Routes.basePage);
      });
    }
    if (kDebugMode) SnackbarCustom.snackbarSucess(setApiUrl());
    Get.offAllNamed(Routes.initialize);
  }

  String setApiUrl() {
    switch (currentEnvironment) {
      case Environment.Production:
        return urls['prod']!;
      case Environment.Hml:
        return urls['hml']!;
      case Environment.Tester:
        return urls['tester']!;
      case Environment.Local:
        return urls['local']!;
    }
  }

  String setSocketUrl() {
    switch (currentEnvironment) {
      case Environment.Production:
        return socket['prod']!;
      case Environment.Hml:
        return socket['hml']!;
      case Environment.Tester:
        return socket['tester']!;
      case Environment.Local:
        return socket['local']!;
    }
  }

  mercadopago.MercadoPago mercadoConfig() {
    switch (currentEnvironment) {
      case Environment.Production:
        return mercadopago.MercadoPago(
          acessToken: dnnConfigs!.mpAcessToken!,
          publicKey: dnnConfigs!.mpPublicKey!,
          applicationId: dnnConfigs!.mpApplicationId!,
          notificationUrl: dnnConfigs!.mpNotificationUrl!,
        );
      case Environment.Tester:
      case Environment.Local:
      case Environment.Hml:
        return mercadopago.MercadoPago(
          acessToken: dnnConfigs!.mpTestAcessToken!,
          publicKey: dnnConfigs!.mpTestPublicKey!,
          applicationId: dnnConfigs!.mpTestApplicationId!,
          notificationUrl: dnnConfigs!.mpTestNotificationUrl!,
        );
    }
  }
}
