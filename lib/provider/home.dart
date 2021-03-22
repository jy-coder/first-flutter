import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/utils/convert.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';

class HomeProvider with ChangeNotifier {
  List<Article> _items = [];
  int _initialPage = 1;
  String _tab = "For You";

  List<Article> get items {
    return [..._items];
  }

  int get initialPage {
    return _initialPage;
  }

  void setTab(String tabName) {
    _items.clear();
    _tab = tabName;
    notifyListeners();
  }

  int getPos(int id, List<Article> list) {
    return list.indexWhere((a) => a.articleId == id);
  }

  void setPageViewArticle(int id) {
    int ind = getPos(id, _items);
    _initialPage = ind;
  }

  Future<void> fetchHome() async {
    List<Map<String, dynamic>> data = [];
    if (_tab == "For You") {
      data = await APIService().get("$RECOMMEND_URL/");
    } else if (_tab == "Trending") {
      data = await APIService().get("$TREND_URL/");
    }

    _items = jsonToArticleList(data);
  }
}
