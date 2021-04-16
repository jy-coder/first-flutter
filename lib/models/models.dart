import 'dart:convert';

import 'package:flutter/foundation.dart';

class Category with ChangeNotifier {
  final int categoryId;
  final String categoryName;

  Category({@required this.categoryId, @required this.categoryName});

  factory Category.fromJson(Map<dynamic, dynamic> json) => Category(
      categoryId: json["category_id"] as int,
      categoryName: json["category_name"] as String);

  // List<Category> parseCategory(String responseBody) {
  //   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  //   return parsed.map<Category>((json) => Category.fromJson(json)).toList();
  // }
}

class Article {
  final int articleId;
  final String title;
  final String category;
  final String link;
  final String summary;
  final String source;
  final String imageUrl;
  final String description;
  final String pubDate;
  final String historyDate;
  final int similarity;
  final String similarHeadline;
  final int likeCount;

  Article({
    @required this.articleId,
    @required this.title,
    @required this.category,
    @required this.link,
    @required this.summary,
    @required this.source,
    @required this.description,
    this.imageUrl,
    this.pubDate,
    this.historyDate,
    this.similarity,
    this.similarHeadline,
    this.likeCount,
  });

  factory Article.fromJson(Map<dynamic, dynamic> json) => Article(
        articleId: json["id"] as int,
        category: json["category"],
        summary: json["summary"],
        source: json["source"],
        link: json["link"],
        title: json["title"],
        imageUrl: json["image_url"],
        description: json["description"],
        pubDate: json["publication_date"],
        historyDate: json["history_date"] != null ? json["history_date"] : "",
        similarity: json["similarity"] as int,
        similarHeadline: json["similar_headline"],
        likeCount: json["count"] as int,
      );
}

class Subscription {
  final int categoryId;
  final String categoryName;
  final bool checked;

  Subscription({
    @required this.categoryId,
    @required this.categoryName,
    this.checked,
  });

  factory Subscription.fromJson(Map<dynamic, dynamic> json) => Subscription(
        categoryId: json["category_id"] as int,
        categoryName: json["category_name"],
      );
}

class SearchSuggestion {
  final int articleId;
  final String title;

  SearchSuggestion({@required this.articleId, @required this.title});

  factory SearchSuggestion.fromJson(Map<dynamic, dynamic> json) =>
      SearchSuggestion(
        articleId: json["article_id"] as int,
        title: json["title"] as String,
      );
}
