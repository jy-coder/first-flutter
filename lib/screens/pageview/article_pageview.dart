import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/screens/pages/article_screen.dart';
import 'package:newheadline/widgets/theme_button.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ArticlePageViewScreen extends StatefulWidget {
  static final routeName = '/article-pageview';
  @override
  _ArticlePageViewScreenState createState() => _ArticlePageViewScreenState();
}

class _ArticlePageViewScreenState extends State<ArticlePageViewScreen> {
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

    if (aProvider.tab == "all_articles" || aProvider.tab == "daily_read")
      articles = aProvider.filteredItems;
    else {
      articles = aProvider.items;
    }
    _initialPage = aProvider.initialPage;
    _controller = PageController(
      initialPage: _initialPage,
    );
    super.didChangeDependencies();
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
        actions: [
          Container(
            child: CustomizeThemeButton(),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 20),
            child: SmoothPageIndicator(
              controller: _controller,
              count: articles.length,
              effect: ScrollingDotsEffect(
                dotWidth: 5.0,
                dotHeight: 5.0,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: PageView(
              controller: _controller,
              children: <Widget>[
                ...articles
                    .map((Article a) => ArticleScreen(
                        id: a.articleId,
                        title: a.title,
                        description: a.description,
                        imageUrl: a.imageUrl,
                        pubDate: a.pubDate,
                        source: a.source,
                        category: a.category,
                        link: a.link))
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
