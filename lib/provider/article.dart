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
  String _tab = "";
  String _subtab = "";
  String _filteredDate = "";

  List<Article> get items {
    return [..._items];
  }

  String get tab {
    return _tab;
  }

  String get subTab {
    return _subtab;
  }

  void setTab(String tabName) {
    _items = [];
    _filteredItems = [];
    _historyItems = [];
    _filteredDate = "";
    _tab = tabName;
    _page = 1;
    _historyPage = 1;
  }

  void setSubTab(String subtabName) {
    _subtab = subtabName;
    notifyListeners();
  }

  void setFilteredDate(String dateRange) {
    _filteredDate = dateRange;
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

  //for lazy loading
  Future<List<Map<String, dynamic>>> fetchArticlesByCategory() async {
    const url = ARTICLE_URL;
    // await Future.delayed(Duration(seconds: 1));

    List<Map<String, dynamic>> data =
        await APIService().get("$url/?page=$_page&category=$_categoryName");
    _page++;

    addToSelectedList(data, _filteredItems);

    return data;
  }

  void filterByCategory(String categoryName) {
    _categoryName = categoryName;
    _page = 1;
    if (categoryName != "all")
      _filteredItems = _items
          .where((Article a) => a.category == categoryName)
          .toSet()
          .toList();
  }

  void getPageViewArticle(int id) {
    int ind = getPos(id, _filteredItems);

    _initialPage = ind + 1;
  }

  Future<List<Map<String, dynamic>>> fetchReadingHistory() async {
    const url = HISTORY_URL;

    List<Map<String, dynamic>> data = await APIService()
        .get("$url/?page=$_historyPage&dateRange=$_filteredDate");

    _historyPage++;

    addToSelectedList(data, _historyItems);

    return data;
  }

  void clearHistory() {
    _historyPage = 1;
    _historyItems = [];
    notifyListeners();
  }

  void filterBookmark(int articleId) {
    _items.removeWhere((item) => item.articleId == articleId);
    _filteredItems.removeWhere((item) => item.articleId == articleId);

    notifyListeners();
  }
}
