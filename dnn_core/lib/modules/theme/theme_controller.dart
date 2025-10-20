import 'package:dnn_core/all_exports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDark = false.obs;

  Map<String, ThemeMode> themeModes = {
    'light': ThemeMode.light,
    'dark': ThemeMode.dark,
  };

  Future<void> setMode(String themeText) async {
    ThemeMode themeMode = themeModes[themeText]!;
    Get.changeThemeMode(themeMode);
    await storage.saveLocalData(key: StorageKeys.theme, data: themeText);
  }

  Future<void> loadThemMode() async {
    String themeText =
        await storage.getLocalData(key: StorageKeys.theme) ?? 'light';
    isDark.value = themeText == 'dark' ? true : false;
    update();
    await setMode(themeText);
  }

  Future<void> changeTheme() async {
    await setMode(isDark.value ? 'light' : 'dark');
    isDark.value = !isDark.value;
  }
}
