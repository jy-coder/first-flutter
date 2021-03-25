import 'dart:async';
import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _items = [];
  Map<String, bool> _checkBoxes = {};
  List<String> _categoryNames = [];

  List<Category> get items {
    return [..._items];
  }

  Map<String, bool> get checkboxes {
    return {..._checkBoxes};
  }

  List<String> get categoryNames {
    return [..._categoryNames];
  }

  Category findById(int id) {
    return _items.firstWhere((cat) => cat.categoryId == id);
  }

  Future<void> fetchCategories(String token) async {
    _categoryNames.clear();
    _items.clear();
    const url = CATEGORIES_URL;
    final List<Map<String, dynamic>> data = await APIService().get(url, token);

    List<Category> items = [];
    Map<String, bool> checkBoxes = {};
    List<String> categoryNames = [];

    for (Map<String, dynamic> d in data) {
      items.add(
        Category.fromJson(d),
      );
      checkBoxes[d['category_id'].toString()] = false;
      categoryNames.add(d['category_name']);
    }

    _items = items;
    _checkBoxes = checkBoxes;
    _categoryNames = categoryNames;
  }

  Future<void> fetchSubscriptionCategories(String token) async {
    _categoryNames.clear();
    _items.clear();
    final data = await APIService().get(USER_SUBSCRIPTION_URL, token);
    for (Map<String, dynamic> d in data) {
      _items.add(
        Category.fromJson(d),
      );
      _categoryNames.add(d['category_name']);
    }
  }
}
