import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:newheadline/models/models.dart';

List<Article> jsonToArticleList(List<Map<String, dynamic>> data) {
  List<Article> articleList = [];
  for (Map<String, dynamic> d in data) {
    articleList.add(
      Article.fromJson(d),
    );
  }
  return articleList;
}

String formatDate(String dateToFormat) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateTime dateTime = dateFormat.parse(dateToFormat);
  final now = DateTime.now();
  String timeAgo = timeago.format(dateTime);
  final today = DateTime(now.year, now.month, now.day);
  final midnight = new DateTime(now.year, now.month, now.day, 23, 59);
  final dateCheck = DateTime(dateTime.year, dateTime.month, dateTime.day);
  if (dateCheck != today) timeAgo = timeago.format(dateTime, clock: midnight);
  // print(dateTime.toString());
  return timeAgo;
}

String capitalize(String toCapitalize) {
  return "${toCapitalize[0].toUpperCase()}${toCapitalize.substring(1)}";
}
