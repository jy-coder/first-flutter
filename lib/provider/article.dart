import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/utils/convert.dart';
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
  int _pageViewCount = 0;
  List<int> _bookmarkIds = [];

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
    _items.clear();
    _filteredItems.clear();
    _tab = tabName;
  }

  void setSubTab(String subtabName) {
    _items.clear();
    _subtab = subtabName;

    notifyListeners();
  }

  void setFilteredDate(String dateRange) {
    _filteredDate = dateRange;
    notifyListeners();
  }

  List<Article> get filteredItems {
    return [..._filteredItems];
  }

  int get initialPage {
    return _initialPage;
  }

  int getPos(int id, List<Article> list) {
    return list.indexWhere((a) => a.articleId == id);
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

  Future<void> fetchAll(String category) async {
    List<Map<String, dynamic>> data =
        await APIService().get("$ARTICLES_URL/?type=$_tab&category=$category");
    if (category == "all") {
      _items = jsonToArticleList(data);
    }

    filterItemsCategory(_categoryName);
  }

  void setPageViewArticle(int id) {
    int ind = 0;
    if (_tab == "all_articles") {
      ind = getPos(id, _filteredItems);
    } else {
      ind = getPos(id, _items);
    }

    _initialPage = ind;
  }

  Future<List<Map<String, dynamic>>> fetchReadingHistory() async {
    List<Map<String, dynamic>> data =
        await APIService().get("$HISTORY_URL/?dateRange=$_filteredDate");

    _items = jsonToArticleList(data);
    await fetchPageViewCount();

    return data;
  }

  Future<List<Map<String, dynamic>>> fetchBookmark() async {
    List<Map<String, dynamic>> data = await APIService().get("$BOOKMARK_URL/");
    _items = jsonToArticleList(data);
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

  // add starred too
  void filterBookmark(int articleId) {
    if (_tab == "all_articles") {
      removeItemFromList(_filteredItems, articleId);
    } else if (_tab == "reading_list") {
      removeItemFromList(_items, articleId);
    }
    notifyListeners();
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

  List<int> get bookmarkIds {
    return _bookmarkIds;
  }

  Future<void> fetchBookmarkId() async {
    Map<String, dynamic> data = {};
    data = await APIService().getOne("$BOOKMARKED_URL");
    _bookmarkIds = data["data"].cast<int>();
  }
}
