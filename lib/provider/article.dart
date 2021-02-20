import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';

class ArticleProvider with ChangeNotifier {
  List<Article> _items = [];
  List<Article> _filteredItems = [];
  int _initialPage = 0;
  String _categoryName = "all"; //default fliter
  int _page = 1;
  String _tab = "";
  String _subtab = "";
  String _filteredDate = "";
  Map<String, int> _categoriesPage = {};

  List<Article> get items {
    return [..._items];
  }

  String get tab {
    return _tab;
  }

  String get subTab {
    return _subtab;
  }

  void setCategoriesPage(Map<String, int> categoriesPage) {
    _categoriesPage = categoriesPage;
  }

  void setTab(String tabName) {
    _categoriesPage.clear();
    _items.clear();
    _filteredItems.clear();
    _tab = tabName;
    _page = 1;
    print(_tab);
  }

  void setSubTab(String subtabName) {
    _items.clear();
    _subtab = subtabName;
    _page = 1;
    notifyListeners();
  }

  void setFilteredDate(String dateRange) {
    _page = 1;
    _filteredDate = dateRange;
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

  Future<List<Map<String, dynamic>>> fetchArticlesByCategory() async {
    List<Map<String, dynamic>> data = await APIService().get(
        "$ARTICLE_URL/?page=${_categoriesPage[_categoryName]}&category=$_categoryName&type=$_tab");

    _categoriesPage[_categoryName]++;

    addToSelectedList(data, _filteredItems);

    return data;
  }

  void filterByCategory(String categoryName) {
    _categoryName = categoryName;
    _page = 1;
    if (categoryName != "all")
      _filteredItems =
          _items.where((Article a) => a.category == categoryName).toList();
  }

  void setPageViewArticle(int id) {
    int ind = getPos(id, _filteredItems);

    _initialPage = ind;
  }

  Future<List<Map<String, dynamic>>> fetchReadingHistory() async {
    List<Map<String, dynamic>> data = await APIService()
        .get("$HISTORY_URL/?page=$_page&dateRange=$_filteredDate");

    _page++;

    addToSelectedList(data, _items);

    return data;
  }

  Future<List<Map<String, dynamic>>> fetchBookmark() async {
    List<Map<String, dynamic>> data =
        await APIService().get("$BOOKMARK_URL/?page=$_page");

    _page++;
    addToSelectedList(data, _items);

    return data;
  }

  void clearHistory() {
    _page = 1;
    _items = [];
    notifyListeners();
  }

  void removeItemFromList(List<Article> list, int articleId) {
    list.removeWhere((item) => item.articleId == articleId);
  }

  void filterBookmark(int articleId) {
    if (_tab == "all_articles") {
      removeItemFromList(_items, articleId);
      removeItemFromList(_filteredItems, articleId);
    } else if (_tab == "reading_list") {
      removeItemFromList(_items, articleId);
    }

    notifyListeners();
  }
}
