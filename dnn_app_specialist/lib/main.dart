import 'dart:io';

import 'package:dnn_dependencies/sc_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'modules/modules.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  AuthBinding().dependencies();
  appContext.setType(AppTypeEnum.SPECIALIST);
  SqfLiteHub.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  if (!kIsWeb) {
    await requestPermissions();
    await ScreenUtil.ensureScreenSize();
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } else if (Platform.isIOS) {
      await Firebase.initializeApp();
    }

    // await FirebasePush().start();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

Future<void> requestPermissions() async {
  final permissions = [
    Permission.notification,
    Permission.camera,
    Permission.microphone,
    if (Platform.isAndroid) ...[
      Permission.requestInstallPackages,
      Permission.manageExternalStorage,
      Permission.storage,
    ]
  ];

  for (final permission in permissions) {
    if (await permission.status.isDenied) {
      await permission.request();
      await permission.status;
    }
  }
}
