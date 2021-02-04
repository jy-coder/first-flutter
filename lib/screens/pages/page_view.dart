import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/widgets/article_page.dart';
import 'package:provider/provider.dart';

class PageViewScreen extends StatefulWidget {
  static final routeName = '/article-pageview';
  @override
  _PageViewScreenState createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  List<Article> articles = [];
  PageController _controller;

  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    articles = aProvider.filteredItems;
    _controller = PageController(
      initialPage: aProvider.initialPage,
    );

    print(aProvider.initialPage);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: articles
          .map((Article a) => ArticlePage(
                id: a.id,
                title: a.title,
                description: a.description,
                imageUrl: 'https://via.placeholder.com/800x500',
                pubDate: DateTime.now().toString(),
                source: a.source,
                category: a.category,
              ))
          .toList(),
    );
  }
}
