import 'package:flutter/foundation.dart';

class Category with ChangeNotifier {
  final int categoryId;
  final String categoryName;
  final String imageUrl;
  Category(
      {@required this.categoryId, @required this.categoryName, this.imageUrl});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        // imageUrl: json["imageUrl"]
      );

  // Map<String, dynamic> toJson() => {
  //       "categoryId": categoryId,
  //       "categoryName": categoryName,
  //       "imageUrl": imageUrl,
  //     };
}

class CategoryArticle {
  final int articleId;
  final String title;
  final String link;
  final String summary;
  final String source;
  final String imageUrl;
  CategoryArticle(
      {@required this.articleId,
      @required this.title,
      @required this.link,
      @required this.summary,
      @required this.source,
      this.imageUrl});
}
