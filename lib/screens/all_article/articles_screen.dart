import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/widgets/article_card.dart';
import 'package:provider/provider.dart';

class ArticlesScreen extends StatefulWidget {
  static final routeName = "/articles";
  final String categoryName;

  ArticlesScreen({this.categoryName});
  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen>
    with AutomaticKeepAliveClientMixin {
  bool _isLoading = false;
  List<Article> articles = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: true);
    List<Article> articles = aProvider.articles[widget.categoryName];

    return _isLoading
        ? CircularProgressIndicator(backgroundColor: Colors.grey)
        : !_isLoading && articles.length > 0
            ? ListView.builder(
                shrinkWrap: true,
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
                  );
                })
            : Container();
  }
}
