import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/utils/common.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';

class ArticleProvider with ChangeNotifier {
  List<Article> _items = [];
  List<Article> _allItems = [];
  int _initialPage = 0;
  String _categoryName = "all"; //default fliter
  String _tab = "";
  String _subtab = "";
  Map<String, String> _filter = {"category": "", "date": "", "newssite": ""};
  String _shareLink = "";
  int _pageViewCount = 0;
  List<int> _bookmarkIds = [];
  List<int> _likeIds = [];
  int _currentArticleId = 0;
  List<Article> _searchItems = [];
  List<Article> _relatedArticles = [];
  bool _filterOpen = false;

  List<Article> get items {
    return [..._items];
  }

  List<Article> get searchItems {
    return [..._searchItems];
  }

  List<Article> get relatedArticle {
    return _relatedArticles;
  }

  String get tab {
    return _tab;
  }

  String get subTab {
    return _subtab;
  }

  String get shareLink {
    return _shareLink;
  }

  int get articleId {
    return _currentArticleId;
  }

  void resetFilter() {
    _filter = {"category": "", "date": "", "newssite": ""};
    notifyListeners();
  }

  void setShareLink(String link) {
    _shareLink = link;
    notifyListeners();
  }

  void setCurrentArticleId(int articleId) {
    _currentArticleId = articleId;
    fetchSimilarArticles();
  }

  void setTab(String tabName) {
    print(tabName);
    _tab = tabName;
  }

  void setSubTab(String subtabName) {
    _items.clear();
    _subtab = subtabName;
    // notifyListeners();
  }

  void setFilter(String type, String choice) {
    _filter[type] = choice;
    notifyListeners();
  }

  Map<String, String> get filter {
    return _filter;
  }

  List<Article> get allItems {
    return [..._allItems];
  }

  int get initialPage {
    return _initialPage;
  }

  int getPos(int id, List<Article> list) {
    return list.indexWhere((a) => a.articleId == id);
  }

  void setFilterOpen(bool val) {
    _filterOpen = val;
  }

  bool get filterOpen {
    return _filterOpen;
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
      _items =
          _allItems.where((Article a) => a.category == categoryName).toList();
    else
      _items = _allItems;

    notifyListeners();
  }

  Future<void> fetchAll(String category) async {
    List<Map<String, dynamic>> data =
        await APIService().get("$ARTICLES_URL/?type=$_tab&category=$category");
    if (category == "all") {
      _allItems = jsonToArticleList(data);
    }

    filterItemsCategory(_categoryName);
  }

  void setPageViewArticle(int id) {
    int ind = 0;
    if (tab == "search")
      ind = getPos(id, _searchItems);
    else
      ind = getPos(id, _items);
    _initialPage = ind;
  }

  void setInitialPage(int pageNum) {
    _initialPage = pageNum;
  }

  Future<List<Map<String, dynamic>>> fetchReadingHistory() async {
    List<Map<String, dynamic>> data =
        await APIService().get("$HISTORY_URL/?dateRange=${_filter['date']}");

    _items = jsonToArticleList(data);

    return data;
  }

  Future<List<Map<String, dynamic>>> fetchBookmark() async {
    List<Map<String, dynamic>> data = await APIService().get("$BOOKMARK_URL/");
    _items = jsonToArticleList(data);

    return data;
  }

  void clearHistory() {
    _items = [];
    notifyListeners();
  }

  void removeItemFromList(int articleId) {
    _items.removeWhere((item) => item.articleId == articleId);

    notifyListeners();
  }

  // add starred too
  void filterBookmark(int articleId) {
    if (_tab == "all_articles") {
      removeItemFromList(articleId);
    } else if (_tab == "reading_list") {
      removeItemFromList(articleId);
    }
    notifyListeners();
  }

  int get pageViewCount {
    return _pageViewCount;
  }

  List<int> get bookmarkIds {
    return _bookmarkIds;
  }

  void addBookmarkIds(int bookmarkId) {
    _bookmarkIds.add(bookmarkId);
    notifyListeners();
  }

  void removeBookmarkIds(int bookmarkId) {
    _bookmarkIds.remove(bookmarkId);
    notifyListeners();
  }

  Future<void> fetchBookmarkId() async {
    Map<String, dynamic> data = {};
    data = await APIService().getOne("$BOOKMARKED_URL");
    if (data != null) _bookmarkIds = data["data"].cast<int>();
  }

  Future<void> fetchSearchResults(String searchResult) async {
    List<Map<String, dynamic>> data =
        await APIService().get("$SEARCH_RESULT_URL/?q=$searchResult");

    _searchItems = jsonToArticleList(data);

    notifyListeners();
  }

  void emptySearch() {
    _searchItems.clear();
  }

  void emptyItems() {
    _items.clear();
  }

  Future<void> fetchHome() async {
    List<Map<String, dynamic>> data = [];
    if (_tab == "daily_read") {
      data = await APIService().get(
          "$RECOMMEND_URL?date=${_filter['date']}&category=${_filter['category']}&site=${_filter['newssite']}");
    } else if (_tab == "trend") {
      data = await APIService().get("$TREND_URL/");
    }

    _items = jsonToArticleList(data);
  }

  Future<void> fetchLikekId() async {
    Map<String, dynamic> data = {};
    data = await APIService().getOne("$LIKED_URL");
    if (data != null) _likeIds = data["data"].cast<int>();
  }

  List<int> get likeIds {
    return _likeIds;
  }

  void addLikeIds(int likeId) {
    _likeIds.add(likeId);
    notifyListeners();
  }

  void removeLikeIds(int likeId) {
    _likeIds.remove(likeId);
    notifyListeners();
  }

  Future<void> fetchSimilarArticles() async {
    String url = "$RELATED_URL?id=$_currentArticleId";
    List<Map<String, dynamic>> relatedArticles = await APIService().get(url);
    _relatedArticles = jsonToArticleList(relatedArticles);
    notifyListeners();
  }
}
