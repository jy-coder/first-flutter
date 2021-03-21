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
