import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
  List<AdWidget> adWidgets;
  int numOfArticlesBeforeAds = 2;

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
    adWidgets = AdMobService.generateAds(2) ;
    return _isLoading
        ? CircularProgressIndicator(backgroundColor: Colors.grey)
        : !_isLoading
            ? ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: articles.length,
                itemBuilder: (ctx, i) {
                  if (i != 0 && i  % numOfArticlesBeforeAds == 0) {
                    return Column(
                      children: [
                        Container(
                          child: adWidgets[((i + 1 )~/ numOfArticlesBeforeAds)],
                          padding: EdgeInsets.zero,
                          margin:  EdgeInsets.zero,
                          height: 50,
                          width: 300,
                        ),
                        ArticleCard(
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
                        )
                      ],
                    );
                  }
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
