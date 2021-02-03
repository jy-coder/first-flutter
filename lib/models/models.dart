import 'dart:convert';

import 'package:flutter/foundation.dart';

class Category with ChangeNotifier {
  final int id;
  final String categoryName;
  final String imageUrl;
  Category({@required this.id, @required this.categoryName, this.imageUrl});

  factory Category.fromJson(Map<dynamic, dynamic> json) => Category(
      id: json["id"] as int,
      categoryName: json["category_name"] as String,
      imageUrl: "https://via.placeholder.com/500x300");

  // List<Category> parseCategory(String responseBody) {
  //   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  //   return parsed.map<Category>((json) => Category.fromJson(json)).toList();
  // }
}

class Article {
  final int id;
  final String title;
  final String category;
  final String link;
  final String summary;
  final String source;
  final String imageUrl;
  final String description;
  final String pubDate;
  final String date;

  Article(
      {@required this.id,
      @required this.title,
      @required this.category,
      @required this.link,
      @required this.summary,
      @required this.source,
      @required this.description,
      this.imageUrl,
      this.pubDate,
      this.date});

  factory Article.fromJson(Map<dynamic, dynamic> json) => Article(
      id: json["id"] as int,
      category: json["category"] as String,
      summary: json["summary"] as String,
      source: json["source"] as String,
      link: json["link"] as String,
      title: json["title"] as String,
      imageUrl: "https://via.placeholder.com/500x300",
      description: json["description"],
      pubDate: json["publication_date"]);
}

class Subscription {
  final int id;
  final String categoryName;
  final bool checked;

  Subscription({
    @required this.id,
    @required this.categoryName,
    this.checked,
  });

  factory Subscription.fromJson(Map<dynamic, dynamic> json) => Subscription(
        id: json["id"] as int,
        categoryName: json["category_name"] as String,
      );
}
