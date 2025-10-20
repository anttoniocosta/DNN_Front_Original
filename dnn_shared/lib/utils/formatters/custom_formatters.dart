import 'package:dnn_dependencies/dnn_dependencies.dart';

abstract class CustomFormatters {
  static final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );
  static final rgFormatter = MaskTextInputFormatter(
    mask: '########-#',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );
  static final cnpjFormatter = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  static final cnpjCpfFormatter = MaskTextInputFormatter(
    mask: '##############',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  static final phoneFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );
  static final zipcodeFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );
  static final dateFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  static final cardNumberFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );
  static final expiryDateFormatter = MaskTextInputFormatter(
    mask: '##/##',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );
  static final ccvFormatter = MaskTextInputFormatter(
    mask: '####',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );
  static final crmFormatter = MaskTextInputFormatter(
    mask: '###.###',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );
  static final stateSubscriptionFormatter = MaskTextInputFormatter(
    mask: '#########',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  static final hourFormatter = MaskTextInputFormatter(
    mask: '##:##',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );
}
