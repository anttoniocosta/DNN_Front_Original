import 'dart:io';

import 'package:dnn_core/all_exports.dart';
import 'package:flutter/foundation.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class AppFunctions {
  static Future<void> urlLauncherWithScheme(String url,
      {String? scheme}) async {
    if (await canLaunchUrl(Uri(scheme: scheme, path: url))) {
      await launchUrl(Uri(scheme: scheme, path: url));
    } else {
      SnackbarCustom.snackbarError('Não foi possível completar a ação.');
    }
  }

  static Future<void> urlLauncherSimples(
    String url,
  ) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      SnackbarCustom.snackbarError('Não foi possível completar a ação.');
    }
  }

  static Future<void> urlLauncherWhatsapp(
      String phoneNumber, String text) async {
    String url = '';
    if (kIsWeb) {
      url =
          "https://api.whatsapp.com/send?phone=+$phoneNumber&text=${Uri.encodeComponent(text)}";
    } else {
      if (Platform.isIOS) {
        url = 'https://wa.me/+$phoneNumber?text=${Uri.encodeComponent(text)}';
      } else {
        url =
            'whatsapp://send?phone=+$phoneNumber&text=${Uri.encodeComponent(text)}';
      }
    }

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      SnackbarCustom.snackbarError('Não foi possível completar a ação.');
    }
  }

  static void openGoogleMaps({
    required String address,
    String? number,
    String? neighboorhood,
    String? city,
    String? state,
    String? zipcode,
  }) {
    String add =
        "$address, ${number ?? "S/N"},${neighboorhood ?? ""}, ${city ?? ""},${state ?? ""}, ${zipcode ?? ""}";
    MapsLauncher.launchQuery(add);
  }
}
