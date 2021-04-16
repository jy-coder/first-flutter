import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
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

  List<String> filterValues = [];
  String selectedValue = "";
  bool refresh = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    aProvider.setTab("history");
    _isLoading = true;
    _loadMore();
    super.didChangeDependencies();
  }

  void _loadMore() async {
    if (!mounted) return;
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    setState(() {
      _isLoading = true;
    });

    await aProvider.fetchReadingHistory();

    setState(() {
      _isLoading = false;
    });
    // });
  }

  @override
  Widget build(BuildContext context) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: true);
    List<Article> historyItems = aProvider.items;
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: historyItems.length,
              itemBuilder: (ctx, i) {
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
                  historyDate: historyItems[i].historyDate,
                );
              }),
    );
  }
}
