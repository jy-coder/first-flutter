import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/widgets/article_card.dart';
import 'package:provider/provider.dart';

class TrendScreen extends StatefulWidget {
  static const routeName = '/trend';
  @override
  _TrendScreenState createState() => _TrendScreenState();
}

class _TrendScreenState extends State<TrendScreen>
    with SingleTickerProviderStateMixin {
  List<Article> articles = [];
  TabController _tabController;
  List<String> categoryNames = [];
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    _fetchTrend();
    super.didChangeDependencies();
  }

  void _fetchTrend() async {
    ArticleProvider hProvider =
        Provider.of<ArticleProvider>(context, listen: false);

    await hProvider.fetchHome();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    if (_tabController != null) {
      _tabController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ArticleProvider hProvider =
        Provider.of<ArticleProvider>(context, listen: true);
    articles = hProvider.items;

    return Scaffold(
      appBar: AppBar(
        title: Text("Trending"),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
              ),
            )
          : !_isLoading
              ? ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: articles.length,
                  itemBuilder: (ctx, i) {
                    return ArticleCard(
                        articles[i].articleId,
                        articles[i].title,
                        articles[i].imageUrl,
                        articles[i].summary,
                        articles[i].link,
                        articles[i].description,
                        articles[i].pubDate,
                        articles[i].source,
                        articles[i].category,
                        likeCount: articles[i].likeCount);
                  })
              : Container(),
    );
  }
}
