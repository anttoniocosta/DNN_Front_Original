import 'package:dnn_dependencies/dnn_dependencies.dart';

extension DateExtensions on DateTime {
  static DateTime setTimezone(DateTime current) {
    return current.subtract(Duration(hours: 3));
  }

  String formatDate() {
    return DateFormat('dd/MM/yyyy', 'pt_Br').format(this);
  }

  String formatDateShort() {
    return DateFormat('dd/MM', 'pt_Br').format(this);
  }

  String formatDateTime() {
    return DateFormat('dd/MM/yyyy HH:mm:ss', 'pt_Br').format(this);
  }

  String formatDateZone() {
    return DateFormat('dd/MM/yyyy', 'pt_Br').format(setTimezone(this));
  }

  String formatDateTimeZone() {
    return DateFormat('dd/MM/yyyy HH:mm:ss', 'pt_Br').format(setTimezone(this));
  }

  String formatWeekdayName() {
    switch (this.weekday) {
      case DateTime.monday:
        return 'S';
      case DateTime.tuesday:
        return 'T';
      case DateTime.wednesday:
        return 'Q';
      case DateTime.thursday:
        return 'Q';
      case DateTime.friday:
        return 'S';
      case DateTime.saturday:
        return 'S';
      case DateTime.sunday:
        return 'D';
    }
    return '';
  }

  bool isSameDay(DateTime day) {
    return this.day == day.day &&
        this.month == day.month &&
        this.year == day.year;
  }
}
