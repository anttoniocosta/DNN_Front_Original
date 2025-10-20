import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color loadingColor = Color(0xff1EE3CF);
  static const Color oldGreyColor = Color(0xffD9D9D9);
  static const Color greyColor = Color(0xfff1f1f1);
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color secondaryTextColor = Color(0xff434E58);
  static const Color textColor = Color(0xff1B1B1B);
  static const Color lighterGreyColor = Color(0xffF0F3F6);
  static const Color lightBlueGreyColor = Color(0xffE3E9ED);
  static const Color darkGreyColor = Color(0xff9CA4AB);
  static const Color primaryColor = Color(0xff0081F8);
  static const Color greenColor = Color(0xffBACE00);
  static const Color successColor = Color(0xff4CD964);
  static const Color warningColor = Color(0xffFF9500);
  static const Color dangerColor = Color(0xffFF1E1E);
  static const Color successBackgroundCardColor = Color(0xffCAF4D1);
  static const Color successDarkBackgroundCardColor = Color(0xff259276);
  static const Color defaultBackgroundCardColor = Color(0xffECF1F6);
  static const Color backgroundCardHomeColor = Color(0x40CACACA);
  static const Color backgroundNavBarColor = Color(0xff034F9B);
  static const Color secondaryColor = Color(0xff1EE0CC);
  static const Color yellowColor = Color(0xffF2C94C);
  static const Color redColor = Color(0xffEB5757);
  static const Color blackLightColor = Color(0xff0D3F67);
  static const Color blackDarkColor = Color(0xff072034);
  static const Color blueDarkColor = Color(0xff002549);
  static const Color midBlackColor = Color(0xff092C48);
  static const Color lighterblackDarkColor = Color(0xff004D99);
  static const Color lighterblackLightColor = Color(0xff255276);
  static const Color blueColor = Color(0xff0081F8);
  static const Color greyColorCard = Color(0xffecf1f6);
  static const Color lighterblueColor = Color(0xff23A6F0);
  static const Color transparent = Colors.transparent;

  static Color cardColor() =>
      Get.isDarkMode ? blackLightColor : const Color.fromRGBO(0, 102, 255, 1);
  static Color containerColor() => Get.isDarkMode ? midBlackColor : whiteColor;

  static Color shimmerBaseColor() =>
      Get.isDarkMode ? midBlackColor : lighterGreyColor;
  static Color shimmerHighlithColor() =>
      Get.isDarkMode ? lighterblackDarkColor : greyColor;

  static Color secondaryButtonColor = const Color(0xff002549);
  static Color badgeColor = const Color(0xffD84658);
  static Color planCardColor = const Color(0xff1B1B1B);
  static Color invoiceCardColor = const Color(0xff153144);
  static Color greenSelectedCardColor = const Color.fromRGBO(76, 217, 100, 0.3);
  static Color blueMarineColor = const Color.fromRGBO(3, 79, 155, 1);
}
