import 'package:intl/intl.dart';
import 'package:newheadline/provider/auth.dart';
import 'package:newheadline/utils/urls.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:newheadline/models/models.dart';
import 'package:web_socket_channel/io.dart';

List<Article> jsonToArticleList(List<Map<String, dynamic>> data) {
  List<Article> articleList = [];
  for (Map<String, dynamic> d in data) {
    articleList.add(
      Article.fromJson(d),
    );
  }
  return articleList;
}

List<String> jsonToStringList(List<Map<String, dynamic>> data) {
  List<String> keywordList = [];
  for (Map<String, dynamic> d in data) {
    keywordList.add(d["keywords"]);
  }
  return keywordList;
}

List<Advertisement> jsonToAdvertList(List<Map<String, dynamic>> data) {
  List<Advertisement> advertList = [];
  for (Map<String, dynamic> d in data) {
    advertList.add(
      Advertisement.fromJson(d),
    );
  }
  return advertList;
}

String formatDate(String dateToFormat) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateTime dateTime = dateFormat.parse(dateToFormat);
  String date = DateFormat.MMMMd('en_US').format(dateTime);
  String timeAgo = timeago.format(dateTime);
  String dateNow = DateFormat.MMMMd('en_US').format(DateTime.now());
  String oneDayAgo = DateFormat.MMMMd('en_US')
      .format(DateTime.now().subtract(const Duration(days: 1)));
  if (date == dateNow || date == oneDayAgo)
    return timeAgo;
  else
    return date;
}

String capitalize(String toCapitalize) {
  return "${toCapitalize[0].toUpperCase()}${toCapitalize.substring(1)}";
}

void socketConnect() {
  final channel = IOWebSocketChannel.connect(WEBSOCKET_URL);
  if (Auth().currentUser != null) {
    channel.sink.add(Auth().currentUser.email);
  }
}

String listToString(List<String> list) {
  return list.join(",");
}

List<String> stringToList(String str) {
  if (str == null) return [];
  return str.split(",");
}
