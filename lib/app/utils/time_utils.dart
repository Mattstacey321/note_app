import 'package:intl/intl.dart';

class TimeUtils {
  static String fullDate(DateTime time) {
    return DateFormat.MMMd().format(time);
  }
}
