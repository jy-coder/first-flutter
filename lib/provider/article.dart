import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';

class ArticleProvider with ChangeNotifier {
  List<Article> _items = [];
  List<Article> _filteredItems = [];
  String _categoryName = "all";
  int _page = 1;

  List<Article> get items {
    return [..._items];
  }

  List<Article> get filteredItems {
    return [..._filteredItems];
  }

  Article findById(int id) {
    return _items.firstWhere((a) => a.id == id);
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
    List<dynamic> data = await APIService().get("$url/?page=$page");

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

  Future<void> filterByCategory(String categoryName) async {
    // print(_page);
    _categoryName = categoryName;
    _page = 0;
    if (categoryName != "all")
      _filteredItems =
          _items.where((Article a) => a.category == categoryName).toList();

    // notifyListeners();
  }
}
