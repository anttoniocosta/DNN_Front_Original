import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/dnn_dependencies.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

abstract class Fonts {
  const Fonts._();

  static BuildContext context = Get.context!;
  static ThemeData theme = Theme.of(context);

  static double get displayExtraLarge => 38;
  static double get displarLarge => 26;
  static double get displayMd => 23;
  static double get heading => 20;
  static double get title => 18;
  static double get titleMd => 17;
  static double get subHeading => 14;
  static double get body => 14;
  static double get caption => 13;
  static double get tiny => 11;
  static double get buttonLarge => 15;
  static double get buttonSmall => 13;

  static FontWeight get bold => FontWeight.w700;
  static FontWeight get light => FontWeight.w300;

  static String get gilroyFontFamily => 'Gilroy';
  static String get nexaFontFamily => 'Nexa';
  static String get nunitoFontFamily => GoogleFonts.nunitoSans().fontFamily!;
  static String get poppins => GoogleFonts.poppins().fontFamily!;

  static TextStyle displayLarge(BuildContext context) =>
      context.fonts.displayLarge!;
  static TextStyle displayMedium(BuildContext context) =>
      context.fonts.displayMedium!;
  static TextStyle displaySmall(BuildContext context) =>
      context.fonts.displaySmall!;
  static TextStyle headlineMedium(BuildContext context) =>
      context.fonts.headlineMedium!;
  static TextStyle headlineSmall(BuildContext context) =>
      context.fonts.headlineSmall!;
  static TextStyle titleLarge(BuildContext context) =>
      context.fonts.titleLarge!;
  static TextStyle titleMedium(BuildContext context) =>
      context.fonts.titleMedium!;
  static TextStyle titleSmall(BuildContext context) =>
      context.fonts.titleSmall!;
  static TextStyle bodyLarge(BuildContext context) => context.fonts.bodyLarge!
      .copyWith(fontWeight: light, fontFamily: nunitoFontFamily);
  static TextStyle bodyMedium(BuildContext context) => context.fonts.bodyMedium!
      .copyWith(fontWeight: light, fontFamily: nunitoFontFamily);
  static TextStyle bodySmall(BuildContext context) => context.fonts.bodySmall!
      .copyWith(fontWeight: light, fontFamily: nunitoFontFamily);
}
