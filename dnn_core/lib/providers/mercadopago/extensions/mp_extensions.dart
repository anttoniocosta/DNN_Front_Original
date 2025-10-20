import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String toFormatMP() {
    final DateFormat formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
    String formattedDate = formatter.format(this);

    // Adiciona o offset de fuso horário
    Duration offset = this.timeZoneOffset;
    String offsetSign = offset.isNegative ? '-' : '+';
    String offsetHours = offset.inHours.abs().toString().padLeft(2, '0');
    String offsetMinutes =
        (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');
    String offsetFormat = '$offsetSign$offsetHours:$offsetMinutes';

    return '$formattedDate$offsetFormat';
  }
}
