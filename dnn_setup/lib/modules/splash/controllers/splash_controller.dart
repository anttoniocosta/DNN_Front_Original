import 'dart:developer';

import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await start();
  }

  Future<void> start() async {
    await userGuuidIdentifier();
    if (kDebugMode) {
      await dbContext.deleteByKey(key: DatabaseModels.helperResponse);
      await dbContext.deleteByKey(key: DatabaseModels.learnMoreResponse);
      await dbContext.deleteByKey(key: DatabaseModels.pagesResponse);
      await dbContext.deleteByKey(key: DatabaseModels.useTermsResponse);
      await dbContext.deleteByKey(key: DatabaseModels.dnnResponse);
      await dbContext.deleteByKey(key: DatabaseModels.maritalStatusModel);
    }
    await getInitialConfigs();
  }

  Future<void> getInitialConfigs() async {
    try {
      await dnnController.loadUrl();
      dnnController.setApiUrl();
      await dnnController.getConfigs();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> userGuuidIdentifier() async {
    try {
      final userGuuid = await storage.getLocalData(key: StorageKeys.uGuuid);
      log('Guuid: ${userGuuid!}');
    } catch (e) {
      await storage.saveLocalData(
        key: StorageKeys.uGuuid,
        data: const Uuid().v4(),
      );
      if (!kIsWeb) {
        final userGuuid = await storage.getLocalData(key: StorageKeys.uGuuid);
        log('Guuid: ${userGuuid!}');
      }
    }
  }
}
