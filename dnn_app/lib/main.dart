import 'dart:io';

import 'package:dnn_dependencies/sc_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

import './core/services/url/unsuported_use_strategy.dart'
    if (dart.library.html) './core/services/url/can_use_strategy.dart';
import 'modules/modules.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  DependencyInjection.init();
  AuthBinding().dependencies();
  SqfLiteHub.init();
  appContext.setType(AppTypeEnum.CLIENT);
  appContext.setCtx(null);
  configUrl();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Initialize Firebase and related services
  if (!kIsWeb) {
    await requestPermissions();
    await ScreenUtil.ensureScreenSize();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebasePush().start();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  // Date formatting and run app
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
