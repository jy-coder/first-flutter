import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';

class ArticleProvider with ChangeNotifier {
  List<Article> _items = [];
  List<Article> _filteredItems = [];
  List<Article> _historyItems = [];
  int _initialPage = 0;
  String _categoryName = "all"; //default fliter
  int _page = 1;
  int _historyPage = 1;
  String _tabs = "";

  List<Article> get items {
    return [..._items];
  }

  String get tabs {
    return _tabs;
  }

  void setTabs(String tabName) {
    _tabs = tabName;
  }

  List<Article> get historyItems {
    return [..._historyItems];
  }

  List<Article> get filteredItems {
    return [..._filteredItems];
  }

  int get initialPage {
    return _initialPage;
  }

  Article findById(int id) {
    return _items.firstWhere((a) => a.articleId == id);
  }

  int getPos(int id, List<Article> list) {
    return list.indexWhere((a) => a.articleId == id);
  }

  String get getFilteredCategory {
    return _categoryName;
  }

  void addToSelectedList(List<Map<String, dynamic>> data, List<Article> list) {
    for (Map<String, dynamic> d in data) {
      list.add(
        Article.fromJson(d),
      );
    }
  }

  Future<List<Map<String, dynamic>>> fetchArticles([int page]) async {
    const url = ARTICLE_URL;
    if (page == null) page = 1;
    List<Map<String, dynamic>> data =
        await APIService().get("$url/?page=$page");

    List<Article> items = [];

    addToSelectedList(data, items);

    _items = items;
    _filteredItems = items.toSet().toList(); //default

    return data;
  }

  //for lazy loading
  Future<List<Map<String, dynamic>>> fetchArticlesByCategory() async {
    const url = ARTICLE_URL;
    // await Future.delayed(Duration(seconds: 1));
    _page++;
    List<Map<String, dynamic>> data =
        await APIService().get("$url/?page=$_page&category=$_categoryName");

    addToSelectedList(data, _filteredItems);

    return data;
  }

  void filterByCategory(String categoryName) {
    _categoryName = categoryName;
    _page = 0;
    if (categoryName != "all")
      _filteredItems =
          _items.where((Article a) => a.category == categoryName).toList();
  }

  void getPageViewArticle(int id) {
    int ind = getPos(id, _filteredItems);

    _initialPage = ind + 1;
  }

  Future<List<Map<String, dynamic>>> fetchReadingHistory() async {
    const url = HISTORY_URL;

    List<Map<String, dynamic>> data =
        await APIService().get("$url/?page=$_historyPage");

    _historyPage++;

    addToSelectedList(data, _historyItems);

    return data;
  }
}
