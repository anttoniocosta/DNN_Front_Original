import 'dart:developer';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:dnn_core/core/routes/route_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RouteObserverMiddleware extends NavigatorObserver {
  static List<String> allowedRoutes = [
    Routes.basePage,
    Routes.authPage,
    Routes.forgetPassword,
    Routes.useTerms,
    Routes.serviceCall,
    Routes.otpValidation,
    Routes.streammingPage,
    Routes.registerZipcode,
    Routes.registerPersonal,
    Routes.paymentChoice,
    Routes.renewalChoice,
    Routes.paymentError,
    Routes.paymentChoiceAddress,
    Routes.creditCardInfos,
    Routes.creditInstallmentsPage,
    Routes.addressForPayment,
    Routes.creditResumeFinishPage,
    Routes.creditCardList,
    Routes.indentifyCCV,
    Routes.paymentStatus,
    Routes.paymentResumePix,
    Routes.paymentResumeBoleto,
    Routes.serviceChoiceDependent,
    Routes.myPlansDetails,
    Routes.myPlansPaymentDetail,
    Routes.refundPlanPage,
    Routes.myEditData,
    Routes.myUpdatePassword,
    Routes.errorPage,
    Routes.helpers,
    Routes.helpersList,
    Routes.helpersDetails,
  ];

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (kIsWeb) {
      try {
        if (allowedRoutes.contains(route.settings.name)) {
          js.context['dataLayer'].callMethod('push', [
            js.JsObject.jsify(
                {'event': "PageView", 'route': route.settings.name})
          ]);
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
