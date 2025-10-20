import 'package:dnn_dependencies/dnn_dependencies.dart';

extension DoubleExtensions on double {
  String formatReal() {
    return UtilBrasilFields.obterReal(this);
  }
}

extension IntExtensions on int {
  String getCurrentMonth() {
    switch (this) {
      case DateTime.january:
        return 'Janeiro';
      case DateTime.february:
        return 'Fevereiro';
      case DateTime.march:
        return 'Março';
      case DateTime.april:
        return 'Abril';
      case DateTime.may:
        return 'Maio';
      case DateTime.june:
        return 'Junho';
      case DateTime.july:
        return 'Julho';
      case DateTime.august:
        return 'Agosto';
      case DateTime.september:
        return 'Setembro';
      case DateTime.october:
        return 'Outubro';
      case DateTime.november:
        return 'Novembro';
      case DateTime.december:
        return 'Dezembro';

      default:
        return '';
    }
  }
}
