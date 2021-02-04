import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/widgets/article_page.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageViewScreen extends StatefulWidget {
  static final routeName = '/article-pageview';
  @override
  _PageViewScreenState createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  List<Article> articles = [];
  PageController _controller;
  int _initialPage = 1;

  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    articles = aProvider.filteredItems;
    _initialPage = aProvider.initialPage;
    _controller = PageController(
      initialPage: _initialPage,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: SmoothPageIndicator(
            controller: _controller,
            count: articles.length,
            effect: ScrollingDotsEffect(
              dotWidth: 10.0,
              dotHeight: 10.0,
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          SmoothPageIndicator(
            controller: _controller,
            count: articles.length,
            effect: ScrollingDotsEffect(),
          ),
          ...articles
              .map((Article a) => ArticlePage(
                    id: a.id,
                    title: a.title,
                    description: a.description,
                    imageUrl: 'https://via.placeholder.com/800x500',
                    pubDate: DateTime.now().toString(),
                    source: a.source,
                    category: a.category,
                  ))
              .toList()
        ],
      ),
    );
  }
}
