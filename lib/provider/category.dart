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
    return _items.firstWhere((cat) => cat.id == id);
  }

  Future<void> fetchCategories([String token]) async {
    const url = CATEGORIES_URL;
    final List<Map<String, dynamic>> data = await APIService().get(url);

    List<Category> items = [];
    Map<String, bool> checkBoxes = {};
    List<String> categoryNames = [];

    for (Map<String, dynamic> d in data) {
      items.add(
        Category.fromJson(d),
      );
      checkBoxes[d['id'].toString()] = false;
      categoryNames.add(d['category_name']);
    }

    _items = items;
    _checkBoxes = checkBoxes;
    _categoryNames = categoryNames;
  }

  void reloadCategory() {
    notifyListeners();
  }
}
