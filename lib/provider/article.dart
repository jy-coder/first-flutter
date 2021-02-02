import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';

class ArticleProvider with ChangeNotifier {
  List<Article> _items = [];
  List<Article> _filteredItems = [];

  List<Article> get items {
    return [..._items];
  }

  List<Article> get filteredItems {
    return [..._filteredItems];
  }

  Article findById(int id) {
    return _items.firstWhere((a) => a.id == id);
  }

  Future<void> fetchArticles() async {
    const url = ARTICLE_URL;
    final data = await APIService().get(url) as List;

    List<Article> items = [];

    for (var d in data) {
      items.add(
        Article.fromJson(d),
      );
    }
    _items = items;
  }

  void filterByCategory(String categoryName) {
    _filteredItems =
        _items.where((Article a) => a.category == categoryName).toList();
    notifyListeners();
  }
}
