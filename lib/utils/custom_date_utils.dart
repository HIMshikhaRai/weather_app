import 'package:intl/intl.dart';

class CustomDateUtils {
  String getDateTime(DateTime dateTime) {
    return "${DateFormat('EEEE').format(dateTime)}, ${dateTime.day} ${DateFormat('MMM').format(dateTime)}";
  }

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  String getTime(DateTime dateTime) {
    return DateFormat.jm().format(dateTime);
  }

  String getDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  getTempInCel(double fahrenheit) {
    return ((fahrenheit - 32) * 5 / 9).toStringAsFixed(1);
  }
}
