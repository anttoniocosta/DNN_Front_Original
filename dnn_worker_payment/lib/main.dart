import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import 'page/home_page.dart';

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
      theme: ThemeData.dark(useMaterial3: true),
      home: const HomePage(),
    );
  }
}
