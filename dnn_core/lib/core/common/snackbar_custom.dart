import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class SnackbarCustom {
  static void snackbarError(String error) {
    Flushbar(
      maxWidth: 500,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      title: 'Atenção!',
      message: error,
      flushbarPosition: Responsive.isTabletOrDesktop()
          ? FlushbarPosition.TOP
          : FlushbarPosition.BOTTOM,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      isDismissible: true,
      backgroundColor: Colors.black,
      duration: const Duration(seconds: 5),
    ).show(Get.context!);
    //_snackbarCustom(text: error, bgColor: Colors.black);
  }

  static void snackbarException(Object e) {
    if (!kReleaseMode)
      Flushbar(
        maxWidth: 500,
        margin: const EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        title: 'Atenção!',
        message: e.toString(),
        flushbarPosition: Responsive.isTabletOrDesktop()
            ? FlushbarPosition.TOP
            : FlushbarPosition.BOTTOM,
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        isDismissible: true,
        backgroundColor: Colors.black,
        duration: const Duration(seconds: 5),
      ).show(Get.context!);
    //_snackbarCustom(text: e.toString(), bgColor: Colors.black);
  }

  static void snackbarSucess(String sucess) {
    Flushbar(
      maxWidth: 500,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      title: 'Sucesso!',
      message: sucess,
      flushbarPosition: Responsive.isTabletOrDesktop()
          ? FlushbarPosition.TOP
          : FlushbarPosition.BOTTOM,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      isDismissible: true,
      backgroundColor: Color.fromARGB(255, 5, 124, 9),
      duration: const Duration(seconds: 3),
    ).show(Get.context!);
    //_snackbarCustom(text: sucess, bgColor: Color.fromARGB(255, 5, 124, 9));
  }
}
