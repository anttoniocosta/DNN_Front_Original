library dnn_core;

import 'package:dnn_dependencies/get_export.dart';

import 'all_exports.dart';
import 'modules/theme/theme_controller.dart';

final dbContext = Get.find<ILocalDb>();

final storage = Get.find<StorageRepository>();
final wsServices = WSServices();
final navigationController = Get.find<NavigationController>();
final providersController = Get.find<ProvidersController>();
final accountController = Get.find<AccountController>();
final phoneController = Get.find<PhoneController>();
final updateAccountController = Get.find<UpdateAccountController>();
final themeController = Get.find<ThemeController>();

final qaController = Get.find<QualityAssuranceController>();
final dnnController = Get.find<DnnController>();
