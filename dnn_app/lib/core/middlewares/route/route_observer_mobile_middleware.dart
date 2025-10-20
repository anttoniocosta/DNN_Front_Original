import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RouteObserverMiddleware extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (kIsWeb) {
      try {
        log(route.settings.name ?? "");
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
