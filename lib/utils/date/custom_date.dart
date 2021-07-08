import 'package:intl/intl.dart';

class CustomDate {
  static String stringDateFromString(String? date) {
    if (date == null) return '';
    if (date == '-' || date == '') return '';
    var parsedDate = DateTime.parse(date);
    return DateFormat("d MMMM yyy").format(parsedDate);
  }

  static String getCurrentDate() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }
}
