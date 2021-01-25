import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';

class CategoryProvider with ChangeNotifier {
  final List<Category> _items = [
    Category(
        categoryId: 1,
        categoryName: 'category1',
        imageUrl: "https://via.placeholder.com/500x300"),
    Category(
        categoryId: 2,
        categoryName: 'category2',
        imageUrl: "https://via.placeholder.com/500x300"),
    Category(
        categoryId: 3,
        categoryName: 'category3',
        imageUrl: "https://via.placeholder.com/500x300"),
    Category(
        categoryId: 4,
        categoryName: 'category4',
        imageUrl: "https://via.placeholder.com/500x300"),
    Category(
        categoryId: 5,
        categoryName: 'category5',
        imageUrl: "https://via.placeholder.com/500x300"),
  ];

  List<Category> get items {
    return [..._items];
  }

  Category findById(int categoryId) {
    return _items.firstWhere((cat) => cat.categoryId == categoryId);
  }

  void reloadCategory() {
    notifyListeners();
  }
}

class CategoryArticleProvider with ChangeNotifier {
  final List<CategoryArticle> _items = [
    CategoryArticle(
        articleId: 1,
        title: 'title1',
        link:
            "http://www.straitstimes.com/world/united-states/china-did-not-fulfil-trade-promises-to-the-us-says-report",
        summary:
            "Nulla sint nostrud aliqua sint ut laborum sunt aliquip reprehenderit Lorem anim et dolore proident. Culpa velit id non elit et voluptate. Ex non cillum voluptate exercitation est mollit est culpa aliqua. Quis qui fugiat velit aute quis non fugiat exercitation. Ad est aliquip commodo exercitation reprehenderit.",
        source: "SOURCE",
        imageUrl: "https://via.placeholder.com/500x300"),
    CategoryArticle(
        articleId: 2,
        title: 'title2',
        link:
            "http://www.straitstimes.com/world/united-states/china-did-not-fulfil-trade-promises-to-the-us-says-report",
        summary:
            "Ea velit est laborum ipsum esse officia amet. Laborum quis mollit mollit occaecat pariatur nostrud tempor deserunt anim ad ut qui velit. Eu nostrud eiusmod mollit sunt officia. Magna mollit in magna non dolor sunt aute commodo eiusmod officia qui ut ad in. Amet ad in id sint. Consequat ipsum enim minim non pariatur ullamco nulla officia anim minim velit do eu.",
        source: "SOURCE",
        imageUrl: "https://via.placeholder.com/500x300"),
    CategoryArticle(
        articleId: 3,
        title: 'title3',
        link:
            "http://www.straitstimes.com/world/united-states/china-did-not-fulfil-trade-promises-to-the-us-says-report",
        summary:
            "Non id ad deserunt voluptate laboris fugiat magna aliquip ea proident commodo dolor pariatur aliqua. Lorem laborum laboris esse do adipisicing fugiat magna ad et fugiat ex proident reprehenderit proident. Dolor deserunt sit fugiat aliqua culpa cupidatat deserunt. In exercitation commodo pariatur nulla labore ut occaecat reprehenderit esse Lorem non. Laborum sit mollit nulla cupidatat.",
        source: "SOURCE",
        imageUrl: "https://via.placeholder.com/500x300"),
    CategoryArticle(
        articleId: 4,
        title: 'title4',
        link:
            "http://www.straitstimes.com/world/united-states/china-did-not-fulfil-trade-promises-to-the-us-says-report",
        summary:
            "Quis sunt nulla adipisicing pariatur ipsum cillum dolor non laborum ut. Anim reprehenderit laborum pariatur aute laborum. Reprehenderit officia duis officia qui do. Ad ea reprehenderit id incididunt eu cupidatat irure elit incididunt. Aute elit laborum incididunt do ad aliqua nulla cupidatat velit et commodo velit anim. Esse do adipisicing laborum elit mollit proident elit ea irure irure. Consequat deserunt laboris nostrud enim in Lorem occaecat.",
        source: "SOURCE",
        imageUrl: "https://via.placeholder.com/500x300"),
    CategoryArticle(
        articleId: 5,
        title: 'title5',
        link:
            "http://www.straitstimes.com/world/united-states/china-did-not-fulfil-trade-promises-to-the-us-says-report",
        summary:
            "Tempor ipsum do consectetur minim nostrud voluptate tempor sunt aute dolor dolor ut. Consequat do do laboris sint cupidatat Lorem anim duis occaecat excepteur ipsum. Minim commodo esse id esse aute aliquip nisi aliquip cupidatat. Sit fugiat sint culpa dolor est veniam. Sunt eu laboris ut ullamco ipsum. Labore dolor nisi anim nostrud occaecat velit.",
        source: "SOURCE",
        imageUrl: "https://via.placeholder.com/500x300"),
  ];

  List<CategoryArticle> get items {
    return [..._items];
  }

  CategoryArticle findById(int articleId) {
    return _items.firstWhere((a) => a.articleId == articleId);
  }

  void reloadCategoryArticle() {
    notifyListeners();
  }
}
