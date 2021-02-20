import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/utils/load_image.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/widgets/article_card.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  static const routeName = "/history";

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _isLoading = true;
  bool _hasMore = true;
  List<String> filterValues = [];
  String selectedValue = "";
  bool refresh = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _hasMore = true;
    _loadMore();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _loadMore() async {
    if (!mounted) return;
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    _isLoading = true;

    aProvider.fetchReadingHistory().then((result) async {
      await Future.wait(aProvider.items
          .map((a) =>
              Utils.cacheImage(context, a.imageUrl, a.articleId.toString()))
          .toList());

      if (result.isEmpty) {
        setState(() {
          _isLoading = false;
          _hasMore = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: true);
    List<Article> historyItems = aProvider.items;
    return Scaffold(
      body: ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: _hasMore ? historyItems.length + 1 : historyItems.length,
          itemBuilder: (ctx, i) {
            if (i >= historyItems.length) {
              if (!_isLoading) {
                _loadMore();
              }
              return Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return ArticleCard(
                historyItems[i].articleId,
                historyItems[i].title,
                historyItems[i].imageUrl,
                historyItems[i].summary,
                historyItems[i].link,
                historyItems[i].description,
                historyItems[i].pubDate,
                historyItems[i].source,
                historyItems[i].category,
                historyItems[i].historyDate);
          }),
    );
  }
}
