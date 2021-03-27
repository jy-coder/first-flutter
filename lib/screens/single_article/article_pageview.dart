import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/screens/single_article/article_screen.dart';
import 'package:newheadline/widgets/share_button.dart';
import 'package:newheadline/widgets/theme_button.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ArticlePageViewScreen extends StatefulWidget {
  static final routeName = '/article-pageview';
  @override
  _ArticlePageViewScreenState createState() => _ArticlePageViewScreenState();
}

class _ArticlePageViewScreenState extends State<ArticlePageViewScreen> {
  bool _isLoading = true;
  List<Article> articles = [];
  PageController _controller;

  void initState() {
    setState(() {
      _isLoading = true;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);

    if (aProvider.tab == "all_articles") {
      articles = aProvider.filteredItems;
    } else {
      articles = aProvider.items;
    }

    _controller = PageController(
      initialPage: aProvider.initialPage,
    );
    setState(() {
      _isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            child: Row(
              children: [
                ShareBtn(link: aProvider.shareLink),
                CustomizeThemeButton(),
              ],
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
              ),
            )
          : Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: aProvider.pageViewCount,
                    effect: ScrollingDotsEffect(
                      dotWidth: 5.0,
                      dotHeight: 5.0,
                      activeDotScale: 2.0,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: PageView(
                    onPageChanged: (int index) {
                      aProvider.setShareLink(articles[index].link);
                    },
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
                                link: a.link,
                              ))
                          .toList()
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
