import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

String formatDate(String dateToFormat) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateTime dateTime = dateFormat.parse(dateToFormat);
  String timeAgo = timeago.format(dateTime);

  return timeAgo;
}
