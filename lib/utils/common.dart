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
  String timeAgo = timeago.format(dateTime);

  return timeAgo;
}

String capitalize(String toCapitalize) {
  return "${toCapitalize[0].toUpperCase()}${toCapitalize.substring(1)}";
}
