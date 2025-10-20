// ignore_for_file: constant_identifier_names

import 'package:dnn_shared/translations/en_US/en_us_translation.dart';

import 'pt_BR/pt_br_translation.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'pt_BR': ptBr,
    'en_US': enUs,
  };
}

abstract class AppTexts {
  static const String DNN = 'DNN';
  static const String WELCOME = 'WELCOME';
  static const String INACTIVE = 'INACTIVE';
  static const String ACTIVE = 'ACTIVE';
  static const String TERMINATED = 'TERMINATED';
  static const String CONTRACT_ACTIVE = 'CONTRACT_ACTIVE';
  static const String CONTRACT_INACTIVE = 'CONTRACT_INACTIVE';
  static const String CONTRACT_TERMINATED = 'CONTRACT_TERMINATED';
}
