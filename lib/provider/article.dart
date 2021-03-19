import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';

class ArticleProvider with ChangeNotifier {
  List<Article> _items = [];
  List<Article> _filteredItems = [];
  int _initialPage = 0;
  String _categoryName = "all"; //default fliter
  String _tab = "";
  String _subtab = "";
  String _filteredDate = "";
  int _lastArticleId = 0;
  int _pageViewCount = 0;
  bool _tabLoading = true;

  List<Article> get items {
    return [..._items];
  }

  String get tab {
    return _tab;
  }

  String get subTab {
    return _subtab;
  }

  bool get tabLoading {
    return _tabLoading;
  }

  void setTabLoading(bool loading) {
    _tabLoading = loading;
  }

  void setTab(String tabName) {
    _items.clear();
    _filteredItems.clear();
    _tab = tabName;
    _lastArticleId = 0;
    setTabLoading(true);
  }

  void setSubTab(String subtabName) {
    print(subtabName);
    _items.clear();
    _subtab = subtabName;

    notifyListeners();
  }

  void setFilteredDate(String dateRange) {
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

  int get lastArticleId {
    if (_lastArticleId == 0)
      return _filteredItems.last.articleId;
    else
      return _lastArticleId;
  }

  void setLastArticleId(int articleId) {
    _lastArticleId = articleId;
  }

  String get category {
    return _categoryName;
  }

  void setCategory(String categoryName) {
    _categoryName = categoryName;
    filterItemsCategory(categoryName);
  }

  void filterItemsCategory(String categoryName) {
    if (categoryName != "all")
      _filteredItems =
          _items.where((Article a) => a.category == categoryName).toList();
    else
      _filteredItems = _items;

    notifyListeners();
  }

  void addToSelectedList(List<Map<String, dynamic>> data, List<Article> list) {
    for (Map<String, dynamic> d in data) {
      list.add(
        Article.fromJson(d),
      );
    }
  }

  List<Article> jsonToArticle(List<Map<String, dynamic>> data) {
    List<Article> articleList = [];
    for (Map<String, dynamic> d in data) {
      articleList.add(
        Article.fromJson(d),
      );
    }
    return articleList;
  }

  Future<List<Article>> fetchAll(String category) async {
    List<Map<String, dynamic>> data =
        await APIService().get("$ARTICLES_URL/?type=$_tab&category=$category");
    if (category == "all") addToSelectedList(data, _items);

    filterItemsCategory(_categoryName);
  }

  void setPageViewArticle(int id) {
    int ind = getPos(id, _filteredItems);

    _initialPage = ind;
  }

  Future<List<Map<String, dynamic>>> fetchReadingHistory() async {
    List<Map<String, dynamic>> data =
        await APIService().get("$HISTORY_URL/?dateRange=$_filteredDate");

    addToSelectedList(data, _items);
    await fetchPageViewCount();

    return data;
  }

  Future<List<Map<String, dynamic>>> fetchBookmark() async {
    List<Map<String, dynamic>> data = await APIService().get("$BOOKMARK_URL/");
    addToSelectedList(data, _items);
    await fetchPageViewCount();

    return data;
  }

  void clearHistory() {
    _items = [];
    notifyListeners();
  }

  void removeItemFromList(List<Article> list, int articleId) {
    list.removeWhere((item) => item.articleId == articleId);

    notifyListeners();
  }

  void filterBookmark(int articleId) {
    if (_tab == "all_articles") {
      removeItemFromList(_filteredItems, articleId);
    } else if (_tab == "reading_list") {
      removeItemFromList(_items, articleId);
    }
  }

  int get pageViewCount {
    return _pageViewCount;
  }

  // get number of articles of each category
  Future<void> fetchPageViewCount() async {
    Map<String, dynamic> data = {};

    if (_tab != "reading_list")
      data = await APIService()
          .getOne("$COUNT_URL/?tabName=$_tab&category=$_categoryName");
    else
      data = await APIService()
          .getOne("$COUNT_URL/?tabName=$_subtab&category=$_categoryName");

    if (data != null) _pageViewCount = data["count"];
  }
}
