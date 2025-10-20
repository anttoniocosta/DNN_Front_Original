import 'dart:async';

import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_setup/dnn_setup.dart';
import 'package:dnn_setup/modules/app_version/export.dart';
import 'package:flutter/foundation.dart';

class InitializeController extends GetxController {
  bool hasError = false;
  String title = "";
  final List<String> titles = [
    InitializeMessages.TITLE_0,
    InitializeMessages.TITLE_1,
    InitializeMessages.TITLE_2,
    InitializeMessages.TITLE_3,
    InitializeMessages.TITLE_4,
    InitializeMessages.TITLE_5,
    InitializeMessages.TITLE_6,
    InitializeMessages.TITLE_7,
    InitializeMessages.TITLE_8,
    InitializeMessages.TITLE_9,
    InitializeMessages.TITLE_10,
  ];

  final List<String> descriptions = [
    InitializeMessages.DESC_0,
    InitializeMessages.DESC_1,
    InitializeMessages.DESC_2,
    InitializeMessages.DESC_3,
    InitializeMessages.DESC_4,
    InitializeMessages.DESC_5,
    InitializeMessages.DESC_6,
    InitializeMessages.DESC_7,
    InitializeMessages.DESC_8,
    InitializeMessages.DESC_9,
    InitializeMessages.DESC_10,
  ];

  int currentIndex = 0;
  late Timer _timer;

  @override
  void onInit() async {
    super.onInit();
    hasError = false;
    _timer = Timer.periodic(const Duration(seconds: 3), _updateText);
  }

  void _updateText(Timer timer) {
    currentIndex = (currentIndex + 1) % titles.length;
    update();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  Future<void> start(Function() onStart) async {
    hasError = false;

    update();
    await getInitialConfigs();
    if (dnnController.onTapError == null) {
      connectivityController.onInit();
      if (!kIsWeb) {
        await appVersionController.getAppVersion();
        if (appVersionController.isNeedingUpgrade) {
          Get.offAll(
            () => const AppVersionPage(),
            transition: Transition.cupertino,
          );
        } else {
          onStart();
        }
      } else {
        onStart();
      }
    } else {
      Get.offAllNamed(Routes.badInternet);
    }
  }

  Future<void> getInitialConfigs() async {
    try {
      await Future.wait([
        accountController.getMaritalStatus(),
      ]);
    } catch (e) {
      hasError = true;
    }
    update();
  }
}
