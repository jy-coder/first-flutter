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
  bool _init = true;

  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
      _init = false;
    });
    filterItems();
  }

  // @override
  // void didChangeDependencies() {
  //   filterItems();
  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    super.dispose();
  }

  void filterItems() async {
    if (!_init)
      setState(() {
        _isLoading = true;
      });
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);

    await aProvider.fetchAll(widget.categoryName);

    await aProvider.fetchPageViewCount();
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: true);
    List<Article> filteredArticles = aProvider.filteredItems;

    return _isLoading
        ? CircularProgressIndicator(backgroundColor: Colors.grey)
        : !_isLoading && filteredArticles.length > 0
            ? ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: filteredArticles.length,
                itemBuilder: (ctx, i) {
                  return ArticleCard(
                    filteredArticles[i].articleId,
                    filteredArticles[i].title,
                    filteredArticles[i].imageUrl,
                    filteredArticles[i].summary,
                    filteredArticles[i].link,
                    filteredArticles[i].description,
                    filteredArticles[i].pubDate,
                    filteredArticles[i].source,
                    filteredArticles[i].category,
                    filteredArticles[i].historyDate == ""
                        ? ""
                        : filteredArticles[i].historyDate,
                  );
                })
            : Container();
  }
}