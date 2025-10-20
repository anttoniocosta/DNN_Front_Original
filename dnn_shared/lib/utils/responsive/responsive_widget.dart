import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? smallMobile;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
    this.smallMobile,
  });

  static bool isSmallMobile() => Get.width < 320;

  static bool isMobile() => Get.width < 768;

  static bool isTablet() => Get.width < 1080 && Get.width >= 768;

  static bool isDesktop() => Get.width >= 1080;

  static bool isTabletOrDesktop() => (isTablet() || isDesktop());

  static double maxWidth() => 700;

  @override
  Widget build(BuildContext context) {
    if (isDesktop()) {
      return desktop;
    } else if (isTablet() && tablet != null) {
      return tablet!;
    } else if (isSmallMobile() && smallMobile != null) {
      return smallMobile!;
    } else {
      return mobile;
    }
  }

  static double doubleSizes(
      {double? small,
      required double mobile,
      required double tablet,
      required double desktop}) {
    if (isSmallMobile()) return small ?? mobile;
    if (isMobile()) return mobile;
    if (isTablet()) return tablet;
    if (isDesktop()) return desktop;
    return mobile;
  }

  static dynamic multReturns({
    dynamic small,
    dynamic mobile,
    required dynamic tablet,
    required dynamic desktop,
  }) {
    if (isSmallMobile()) return small ?? mobile;
    if (isMobile()) return mobile;
    if (isTablet()) return tablet;
    if (isDesktop()) return desktop;
    return mobile;
  }
}
