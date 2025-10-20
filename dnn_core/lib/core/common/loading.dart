import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class Loading {
  static void hide() => Get.back();
  static void show({String? title}) {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      barrierColor: Get.isDarkMode ? Colors.black45 : Colors.black12,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
            child: Dialog(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Get.theme.colorScheme.tertiary),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator.adaptive(),
                      if (title != null) SizedBox(height: 10),
                      if (title != null)
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: Fonts.titleLarge(context),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
