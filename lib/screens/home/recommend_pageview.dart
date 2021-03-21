import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/home.dart';
import 'package:newheadline/screens/single_article/article_screen.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RecommendPageViewScreen extends StatefulWidget {
  static final routeName = '/Recommend-pageview';

  final List<Article> articles;
  RecommendPageViewScreen({this.articles});

  @override
  _RecommendPageViewScreenState createState() =>
      _RecommendPageViewScreenState();
}

class _RecommendPageViewScreenState extends State<RecommendPageViewScreen> {
  List<Article> articles = [];
  PageController _controller;

  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    HomeProvider hProvider = Provider.of<HomeProvider>(context, listen: false);
    articles = hProvider.items;
    _controller = PageController(
      initialPage: hProvider.initialPage,
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
      appBar: AppBar(),
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
                        ))
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
