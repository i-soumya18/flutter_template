import 'package:intl/intl.dart';

class Formatters {
  const Formatters._();

  static String date(DateTime value) => DateFormat('MMM d, y').format(value);
  static String time(DateTime value) => DateFormat('h:mm a').format(value);
}
