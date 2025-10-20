import 'dart:io';

import 'package:dnn_dependencies/dnn_dependencies.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_setup/modules/app_version/export.dart';
import 'package:flutter/foundation.dart';

class AppVersionController extends GetxController {
  final IAppVersionRepository _repository;

  AppVersionController(this._repository);

  AppVersionModel? appModel;

  bool isNeedingUpgrade = false;

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    String versionUnited = "${version.replaceAll('.', '')}$buildNumber";
    String packageName = packageInfo.packageName;

    int versionNumber = int.parse(versionUnited);

    try {
      final result = await _repository.getAppVersion(packageName: packageName);

      if (result.data != null) {
        appModel = result.data;
        update();
        if (Platform.isAndroid) {
          handleAppVersion(
            parserVersionToInt(appModel!.android!),
            versionNumber,
          );
        }

        if (Platform.isIOS) {
          handleAppVersion(
            parserVersionToInt(appModel!.ios!),
            versionNumber,
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  handleAppVersion(int versionOnStore, int clientVersion) {
    if (clientVersion < versionOnStore) {
      isNeedingUpgrade = true;
      update();
    }
  }

  parserVersionToInt(String version) {
    return int.parse(version.replaceAll('.', '').replaceAll('+', ''));
  }
}
