import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/utils/load_image.dart';
import 'package:newheadline/widgets/article_card.dart';
import 'package:provider/provider.dart';

class ArticlesScreen extends StatefulWidget {
  static final routeName = "/articles";

  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen>
    with AutomaticKeepAliveClientMixin {
  bool _isLoading = true;
  bool _hasMore = true;
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // print("init called");
    super.initState();
    _isLoading = true;
    _hasMore = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMore();
      // print("mounted value:$mounted");
    });
  }

  @override
  void dispose() {
    // print("disposed");
    super.dispose();
  }

  void _loadMore() async {
    if (!mounted) return;
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    _isLoading = true;
    aProvider.fetchArticlesByCategory().then((result) async {
      List<Future> futures = [];

      aProvider.filteredItems.asMap().forEach((index, a) {
        futures.add(Utils.cacheImage(
          context,
          a.imageUrl,
          a.id.toString(),
        ));
      });
      await Future.wait(futures);

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
    super.build(context);
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    List<Article> filteredArticles = aProvider.filteredItems;
    return ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount:
            _hasMore ? filteredArticles.length + 1 : filteredArticles.length,
        itemBuilder: (ctx, i) {
          // Don't trigger if one async loading is already under way
          if (i >= filteredArticles.length) {
            // Don't trigger if one async loading is already under way
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
            filteredArticles[i].id,
            filteredArticles[i].title,
            filteredArticles[i].imageUrl,
            filteredArticles[i].summary,
            filteredArticles[i].link,
            filteredArticles[i].description,
            filteredArticles[i].pubDate,
            filteredArticles[i].source,
            filteredArticles[i].category,
          );
        });
  }
}
