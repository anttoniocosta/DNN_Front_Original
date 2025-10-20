import 'dart:async';
import 'dart:developer';

import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/dnn_dependencies.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_setup/dnn_setup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ConnectionManagerController extends GetxController {
  //0 = No Internet, 1 = WIFI Connected ,2 = Mobile Data Connected.
  var connectionType = 0.obs;

  final Connectivity _connectivity = Connectivity();

  late StreamSubscription _streamSubscription;

  RxBool isLoading = false.obs;
  setLoading(bool val) {
    isLoading.value = true;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getConnectivityType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void> getConnectivityType() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        log(e.message!);
      }
    }
    return _updateState(connectivityResult);
  }

  _updateState(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType.value = 1;
        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;
        break;
      case ConnectivityResult.none:
        connectionType.value = 0;
        Get.toNamed(Routes.noInternet);
        break;
      default:
        break;
    }
  }

  Future<void> getBaseConfigs() async {
    switch (connectionType.value) {
      case 1:
      case 2:
        await splashController.getInitialConfigs();
        await accountController.getAccount();
        // if (AppTrigger.isAppPartner && accountController.userCreated != null) {
        //   authController.getLoginList();
        // }
        Get.back();
        break;
      case 0:
        getConnectivityType();
        break;
      default:
        break;
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}
