import 'package:dnn_app_seller/core/core.dart';
import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/sc_util.dart';
import 'package:dnn_setup/dnn_setup.dart';
import 'package:dnn_shared/res/theme/app_themes.dart';
import 'package:dnn_shared/translations/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
          title: 'Doutor na Net - Vendas',
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
