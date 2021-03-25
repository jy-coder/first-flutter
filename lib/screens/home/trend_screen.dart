import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/auth.dart';
import 'package:newheadline/provider/home.dart';
import 'package:newheadline/widgets/article_card.dart';
import 'package:newheadline/widgets/home_card.dart';
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
  void initState() {
    _fetchTrend();
    super.initState();
  }

  void _fetchTrend() async {
    HomeProvider hProvider = Provider.of<HomeProvider>(context, listen: false);
    Auth auProvider = Provider.of<Auth>(context, listen: false);

    await hProvider.fetchHome(auProvider.token);
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
    HomeProvider hProvider = Provider.of<HomeProvider>(context, listen: true);
    articles = hProvider.items;

    return _isLoading
        ? CircularProgressIndicator(backgroundColor: Colors.grey)
        : !_isLoading
            ? ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: articles.length,
                itemBuilder: (ctx, i) {
                  return HomeCard(
                    articles[i].articleId,
                    articles[i].title,
                    articles[i].imageUrl,
                    articles[i].summary,
                    articles[i].link,
                    articles[i].description,
                    articles[i].pubDate,
                    articles[i].source,
                    articles[i].category,
                  );
                })
            : Container();
  }
}
