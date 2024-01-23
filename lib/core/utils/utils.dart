import 'package:intl/intl.dart';

class Utils {
  static String convertTimestamp(String date) {
    //String timestamp = '2023-05-14 12:46:29';
    DateTime parsedDateTime = DateTime.parse(date);

    return DateFormat('dd MMM yyyy hh:mm a').format(parsedDateTime);
  }

  static int currentYear() {
    final now = DateTime.now();
    String formatter = DateFormat('y').format(now);

    return int.parse(formatter);
  }

  static String todayDate() {
    final now = DateTime.now();
    return DateFormat('y-MM-d').format(now);
  }
}
