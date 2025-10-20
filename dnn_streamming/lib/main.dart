import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_streamming/modules/binding/streamming_binding.dart';
import 'package:flutter/material.dart';

import 'modules/pages/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onInit: () {
        themeController.loadThemMode();
        dnnController.loadUrl();
      },
      initialBinding: StreammingBinding(),
      debugShowCheckedModeBanner: false,
      theme: AppThemes.themeLight(),
      darkTheme: AppThemes.themeDark(),
      home: const Home(),
    );
  }
}
