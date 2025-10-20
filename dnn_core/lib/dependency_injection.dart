import 'package:dnn_dependencies/dnn_dependencies.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'all_exports.dart';
import 'modules/theme/theme_controller.dart';

abstract class DependencyInjection {
  static void init() {
    Get.put<HttpManager>(
      HttpManager(
        Dio(
          BaseOptions(
            connectTimeout: const Duration(minutes: 5),
            receiveTimeout: const Duration(minutes: 5),
          ),
        ),
      ),
    );
    Get.put<ILocalDb>(LocalDb());

    Get.put<StorageRepository>(StorageRepository());
    Get.put<IProvidersRepository>(ProvidersRepository(Get.find()));
    Get.put<IAccountRepository>(AccountRepository(Get.find()));
    Get.put<IDnnRepository>(DnnRepository(Get.find()));

    Get.put<NavigationController>(NavigationController());
    Get.put<ThemeController>(ThemeController());
    Get.put<ProvidersController>(ProvidersController(Get.find()));
    Get.put<AccountController>(AccountController(Get.find()));
    Get.put<UpdateAccountController>(UpdateAccountController(Get.find()));
    Get.put<PhoneController>(PhoneController(Get.find()));
    Get.put<DnnController>(DnnController(Get.find()));
  }
}
