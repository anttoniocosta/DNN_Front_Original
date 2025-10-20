import 'package:flutter/material.dart';

import '../../dnn_shared.dart';

class AppThemes {
  static ThemeData themeLight() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.whiteColor,
      fontFamily: Fonts.gilroyFontFamily,
      brightness: Brightness.light,
      useMaterial3: baseTheme.useMaterial3,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        displayLarge: baseTheme.textTheme.displayLarge,
        displayMedium: baseTheme.textTheme.displayMedium,
        displaySmall: baseTheme.textTheme.displaySmall,
        headlineMedium: baseTheme.textTheme.headlineMedium,
        headlineSmall: baseTheme.textTheme.headlineSmall,
        titleLarge: baseTheme.textTheme.titleLarge,
        titleMedium: baseTheme.textTheme.titleMedium,
        titleSmall: baseTheme.textTheme.titleSmall,
        bodyLarge: baseTheme.textTheme.bodyLarge,
        bodyMedium: baseTheme.textTheme.bodyMedium,
        bodySmall: baseTheme.textTheme.bodySmall,
      ),
      textButtonTheme: baseTheme.textButtonTheme,
      elevatedButtonTheme: baseTheme.elevatedButtonTheme,
      outlinedButtonTheme: baseTheme.outlinedButtonTheme,
      filledButtonTheme: baseTheme.filledButtonTheme,
      appBarTheme:
          baseTheme.appBarTheme.copyWith(backgroundColor: AppColors.whiteColor),
      cardColor: AppColors.whiteColor,
      bottomSheetTheme: baseTheme.bottomSheetTheme,
      bottomAppBarTheme: baseTheme.bottomAppBarTheme,
      dividerTheme: baseTheme.dividerTheme.copyWith(),
      progressIndicatorTheme: baseTheme.progressIndicatorTheme,
      inputDecorationTheme: baseTheme.inputDecorationTheme
          .copyWith(fillColor: AppColors.greyColor.withOpacity(0.7)),
      cardTheme: baseTheme.cardTheme.copyWith(
        color: AppColors.whiteColor,
        surfaceTintColor: AppColors.whiteColor,
      ),
      dialogTheme: baseTheme.dialogTheme
          .copyWith(surfaceTintColor: AppColors.whiteColor),
      bottomNavigationBarTheme: baseTheme.bottomNavigationBarTheme,
      iconTheme: baseTheme.iconTheme,
      colorScheme:
          const ColorScheme.light().copyWith(tertiary: AppColors.whiteColor),
    );
  }

  static ThemeData themeDark() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.black,
      fontFamily: Fonts.gilroyFontFamily,
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      useMaterial3: baseTheme.useMaterial3,
      textButtonTheme: baseTheme.textButtonTheme,
      elevatedButtonTheme: baseTheme.elevatedButtonTheme,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.whiteColor,
          side: const BorderSide(width: 2, color: AppColors.whiteColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
        ),
      ),
      filledButtonTheme: baseTheme.filledButtonTheme,
      appBarTheme: baseTheme.appBarTheme.copyWith(
        surfaceTintColor: AppColors.midBlackColor,
        backgroundColor: AppColors.midBlackColor,
      ),
      bottomSheetTheme: baseTheme.bottomSheetTheme,
      bottomNavigationBarTheme: baseTheme.bottomNavigationBarTheme,
      dividerTheme: baseTheme.dividerTheme
          .copyWith(color: AppColors.whiteColor.withOpacity(0.2)),
      progressIndicatorTheme: baseTheme.progressIndicatorTheme,
      inputDecorationTheme: baseTheme.inputDecorationTheme
          .copyWith(fillColor: baseTheme.cardTheme.surfaceTintColor),
      textTheme: TextTheme(
        displayLarge: baseTheme.textTheme.displayLarge!
            .copyWith(color: AppColors.whiteColor),
        displayMedium: baseTheme.textTheme.displayMedium!
            .copyWith(color: AppColors.whiteColor),
        displaySmall: baseTheme.textTheme.displaySmall!
            .copyWith(color: AppColors.whiteColor),
        headlineMedium: baseTheme.textTheme.headlineMedium!
            .copyWith(color: AppColors.whiteColor),
        headlineSmall: baseTheme.textTheme.headlineSmall!
            .copyWith(color: AppColors.whiteColor),
        titleLarge: baseTheme.textTheme.titleLarge!
            .copyWith(color: AppColors.whiteColor),
        titleMedium: baseTheme.textTheme.titleMedium!
            .copyWith(color: AppColors.whiteColor),
        titleSmall: baseTheme.textTheme.titleSmall!
            .copyWith(color: AppColors.whiteColor),
        bodyLarge: baseTheme.textTheme.bodyLarge!
            .copyWith(color: AppColors.whiteColor),
        bodyMedium: baseTheme.textTheme.bodyMedium!
            .copyWith(color: AppColors.whiteColor),
        bodySmall: baseTheme.textTheme.bodySmall!
            .copyWith(color: AppColors.whiteColor),
      ),
      cardTheme: baseTheme.cardTheme.copyWith(
          surfaceTintColor: AppColors.midBlackColor,
          color: AppColors.midBlackColor),
      dialogTheme: baseTheme.dialogTheme,
      iconTheme: baseTheme.iconTheme,
      colorScheme:
          const ColorScheme.dark().copyWith(tertiary: AppColors.midBlackColor),
    );
  }
}

final ThemeData baseTheme = ThemeData(
    useMaterial3: true,
    fontFamily: Fonts.gilroyFontFamily,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        textStyle:
            TextStyle(fontSize: Fonts.title, fontFamily: Fonts.nexaFontFamily),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blueColor,
        foregroundColor: AppColors.whiteColor,
        surfaceTintColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.secondaryButtonColor,
        surfaceTintColor: AppColors.secondaryButtonColor,
        side: BorderSide(width: 2, color: AppColors.secondaryButtonColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.blueColor,
        foregroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      toolbarHeight: 60,
      elevation: 10,
      centerTitle: true,
      backgroundColor: AppColors.blueColor,
      foregroundColor: AppColors.whiteColor,
      titleTextStyle: textTheme.headlineMedium,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.shifting,
      elevation: 10,
      selectedItemColor: AppColors.blueColor,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
    dividerTheme:
        const DividerThemeData(thickness: 1, color: AppColors.greyColor),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: AppColors.loadingColor),
    inputDecorationTheme: InputDecorationTheme(
      alignLabelWithHint: true,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      focusColor: AppColors.blueColor,
      isDense: false,
      isCollapsed: false,
      filled: true,
      focusedBorder: border.copyWith(
          borderSide: const BorderSide(width: 4, color: AppColors.blueColor)),
      border: border,
      enabledBorder: border,
      focusedErrorBorder: border.copyWith(
          borderSide: const BorderSide(width: 4, color: AppColors.redColor)),
      errorBorder: border,
    ),
    textTheme: textTheme.copyWith(),
    cardTheme: const CardTheme(clipBehavior: Clip.none, elevation: 5),
    dialogTheme: const DialogTheme(shape: RoundedRectangleBorder()),
    iconTheme: const IconThemeData(size: 20));

const border = UnderlineInputBorder(
  borderSide: BorderSide.none,
  borderRadius: BorderRadius.all(Radius.circular(radiusMedium)),
);

final textTheme = TextTheme(
  displayLarge: TextStyle(
      fontSize: Fonts.displayExtraLarge,
      color: AppColors.textColor,
      fontWeight: Fonts.bold,
      fontFamily: Fonts.gilroyFontFamily),
  displayMedium: TextStyle(
      fontSize: Fonts.displarLarge,
      color: AppColors.textColor,
      fontWeight: Fonts.bold,
      fontFamily: Fonts.gilroyFontFamily),
  displaySmall: TextStyle(
      fontSize: Fonts.displayMd,
      color: AppColors.textColor,
      fontWeight: Fonts.bold,
      fontFamily: Fonts.gilroyFontFamily),
  headlineMedium: TextStyle(
      fontSize: Fonts.heading,
      color: AppColors.textColor,
      fontWeight: Fonts.bold,
      fontFamily: Fonts.gilroyFontFamily),
  headlineSmall: TextStyle(
      fontSize: Fonts.subHeading,
      color: AppColors.textColor,
      fontWeight: Fonts.bold,
      fontFamily: Fonts.gilroyFontFamily),
  titleLarge: TextStyle(
      fontSize: Fonts.title,
      color: AppColors.textColor,
      fontWeight: Fonts.bold,
      fontFamily: Fonts.gilroyFontFamily),
  titleMedium: TextStyle(
      fontSize: Fonts.titleMd,
      color: AppColors.textColor,
      fontWeight: Fonts.bold,
      fontFamily: Fonts.gilroyFontFamily),
  titleSmall: TextStyle(
      fontSize: Fonts.subHeading,
      color: AppColors.textColor,
      fontWeight: Fonts.bold,
      fontFamily: Fonts.gilroyFontFamily),
  bodyLarge: TextStyle(
      fontSize: Fonts.body,
      color: AppColors.textColor,
      fontWeight: Fonts.light,
      fontFamily: Fonts.nunitoFontFamily),
  bodyMedium: TextStyle(
      fontSize: Fonts.caption,
      color: AppColors.textColor,
      fontWeight: Fonts.light,
      fontFamily: Fonts.nunitoFontFamily),
  bodySmall: TextStyle(
      fontSize: Fonts.tiny,
      color: AppColors.textColor,
      fontWeight: Fonts.light,
      fontFamily: Fonts.nunitoFontFamily),
);
