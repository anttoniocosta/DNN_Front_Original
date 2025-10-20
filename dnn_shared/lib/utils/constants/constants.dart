import 'package:flutter/material.dart';

class AppConstants {
  static const stateList = [
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MS',
    'MT',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO'
  ];
  static get pdHorizontal => const EdgeInsets.symmetric(horizontal: 16);
  static get pdPage => const EdgeInsets.only(left: 16, right: 16, top: 10);
  static get contentPadding =>
      const EdgeInsets.symmetric(horizontal: 15, vertical: 10);
}
