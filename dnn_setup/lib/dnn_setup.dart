library dnn_setup;

import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_setup/dnn_setup.dart';
import 'package:dnn_setup/modules/app_version/export.dart';

export './modules/export.dart';

final splashController = Get.find<SplashController>();
final initializeController = Get.find<InitializeController>();
final connectivityController = Get.find<ConnectionManagerController>();
final appVersionController = Get.find<AppVersionController>();
