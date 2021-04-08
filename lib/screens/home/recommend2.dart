import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/utils/admob.dart';
import 'package:newheadline/widgets/article_card.dart';
import 'package:provider/provider.dart';

class RecommendScreen2 extends StatefulWidget {
  static const routeName = '/recommend2';

  @override
  _RecommendScreen2State createState() => _RecommendScreen2State();
}

class _RecommendScreen2State extends State<RecommendScreen2>
    with SingleTickerProviderStateMixin {
  List<Article> articles = [];
  TabController _tabController;
  List<String> categoryNames = [];
  bool _isLoading = true;

  @override
  void initState() {
    _fetchRecommend();
    super.initState();
  }

  void _fetchRecommend() async {
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

    return _isLoading
        ? CircularProgressIndicator(backgroundColor: Colors.grey)
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
                    similarHeadline: articles[i].similarHeadline,
                    similarity: articles[i].similarity,
                  );
                })
            : Container();
    // :ElevatedButton(
    //     child: Text("click here"),
    //     onPressed: () => AdMobService.createBannerAd(),
    //   );
  }
}
