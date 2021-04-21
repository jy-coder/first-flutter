import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/auth.dart';
import 'package:newheadline/utils/common.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';
import 'package:newheadline/widgets/article_card.dart';
import 'package:provider/provider.dart';
import 'package:newheadline/utils/admob.dart';

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
  List<String> keywords = [];
  List<AdWidget> adWidgets;
  int numOfArticlesBeforeAds = 5;
  bool _isLoading = false;
  bool _isUpdating = false;

  @override
  void initState() {
    _fetchRecommend();
    _fetchKeywords();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _fetchKeywords() async {
    List<Map<String, dynamic>> data = await APIService().get("$AD_URL");
    setState(() {
      keywords = jsonToStringList(data);
    });
  }

  void _fetchRecommend() async {
    setState(() {
      _isLoading = true;
    });
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

  Future<void> refreshHome() async {
    setState(() {
      _isUpdating = true;
    });
    socketConnect();

    Future.delayed(const Duration(milliseconds: 200), () {
      _fetchRecommend();
      setState(() {
        _isUpdating = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ArticleProvider hProvider =
        Provider.of<ArticleProvider>(context, listen: true);
    articles = hProvider.items;
    adWidgets = AdMobService.generateAds(keywords.length, keywords);
    // print(keywords);
    return _isUpdating
        ? Text("Loading")
        : _isLoading
            ? CircularProgressIndicator(
                backgroundColor: Colors.grey,
              )
            : !_isLoading
                ? RefreshIndicator(
                    onRefresh: () => refreshHome(),
                    child: ListView.builder(
                        padding: const EdgeInsets.all(10.0),
                        itemCount: articles.length,
                        itemBuilder: (ctx, i) {
                          if (i != 0 && i % numOfArticlesBeforeAds == 0) {
                            return Column(
                              children: [
                                Container(
                                  child: adWidgets[
                                      ((i + 1) ~/ numOfArticlesBeforeAds)],
                                  padding: EdgeInsets.zero,
                                  margin: EdgeInsets.zero,
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
                        }),
                  )
                : Container();
    // :ElevatedButton(
    //     child: Text("click here"),
    //     onPressed: () => AdMobService.createBannerAd(),
    //   );
  }
}
