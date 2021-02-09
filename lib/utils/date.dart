import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

String formatDate(String dateToFormat) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateTime dateTime = dateFormat.parse(dateToFormat);
  String timeAgo = timeago.format(dateTime);

  return timeAgo;
}

Map<String, String> getRangeOfDate() {
  List<String> dates = [];

  List<int> dateRange = [0, 1, 7, 14, 30];

  List<String> displayedDate = [
    "Today",
    "One day ago",
    "One week ago",
    "Two weeks ago",
    "One month ago"
  ];

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  for (int day in dateRange) {
    DateTime daysAgo = DateTime.now().subtract(Duration(days: day));
    String datedaysAgo = dateFormat.format(daysAgo);
    dates.add(datedaysAgo);
  }

  final Map<String, String> dateMap = Map.fromIterables(dates, displayedDate);

  return dateMap;
}
