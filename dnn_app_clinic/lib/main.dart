import 'dart:io';

import 'package:dnn_app_clinic/firebase_options.dart';
import 'package:dnn_authentication/core/binding/auth_binding.dart';
import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/dnn_dependencies.dart';
import 'package:dnn_dependencies/sc_util.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  AuthBinding().dependencies();
  appContext.setType(AppTypeEnum.CLINIC);
  SqfLiteHub.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  if (!kIsWeb) {
    await requestPermissions();
    await ScreenUtil.ensureScreenSize();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebasePush().start();

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
