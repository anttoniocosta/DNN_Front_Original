import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/sc_util.dart';
import 'package:dnn_setup/dnn_setup.dart';
import 'package:dnn_shared/res/theme/app_themes.dart';
import 'package:dnn_shared/translations/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          onInit: () {
            themeController.loadThemMode();
            dnnController.loadUrl();
          },
          debugShowCheckedModeBanner: false,
          title: 'Doutor na Net - Clínica',
          theme: AppThemes.themeLight(),
          darkTheme: AppThemes.themeDark(),
          getPages: AppPages.pages,
          initialRoute: Routes.splashPage,
          initialBinding: SplashBinding(),
          locale: const Locale('pt', 'BR'),
          translationsKeys: AppTranslation.translations,
        );
      },
    );
  }
}
