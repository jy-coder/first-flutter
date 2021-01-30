import 'package:flutter/foundation.dart';

class Category with ChangeNotifier {
  final int id;
  final String categoryName;
  final String imageUrl;
  Category({@required this.id, @required this.categoryName, this.imageUrl});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categoryName: json["categoryName"],
        // imageUrl: json["imageUrl"]
      );
}

class Article {
  final int id;
  final String title;
  final String link;
  final String summary;
  final String source;
  final String imageUrl;
  Article(
      {@required this.id,
      @required this.title,
      @required this.link,
      @required this.summary,
      @required this.source,
      this.imageUrl});
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
}
