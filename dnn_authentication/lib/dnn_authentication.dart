library dnn_authentication;

import 'package:dnn_authentication/core/controllers/authentication_controller.dart';
import 'package:get/get.dart';

export './core/export.dart';
export './modules/export.dart';
export './shared/export.dart';
export 'package:dnn_pages/dnn_pages.dart';

final authenticationController = Get.find<AuthenticationController>();
