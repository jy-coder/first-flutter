import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/screens/pages/article_screen.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';
import 'package:provider/provider.dart';

class ArticleLoadScreen extends StatefulWidget {
  final int loadArticleScreenId;
  ArticleLoadScreen(this.loadArticleScreenId);
  @override
  _ArticleLoadScreenState createState() => _ArticleLoadScreenState();
}

class _ArticleLoadScreenState extends State<ArticleLoadScreen> {
  bool _isLoading = false;
  Article _a;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchArticle();
    });
  }

  @override
  void didChangeDependencies() {
    // _fetchArticle();
    print("changing dependencies");
    super.didChangeDependencies();
  }

  void _fetchArticle() async {
    print(widget.loadArticleScreenId);
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    setState(() {
      _isLoading = true;
    });
    String swipeDirection =
        aProvider.detectSwipeDirection(widget.loadArticleScreenId);
    print(swipeDirection);
    Map<String, dynamic> data = await APIService().getOne(
        "$ARTICLE_URL/?article_id=${aProvider.lastArticleId}&category=${aProvider.getFilteredCategory}&tabName=${aProvider.tab}&swipe=$swipeDirection");
    Article article = Article.fromJson(data); // retrieve from backend
    // print(article.articleId);
    aProvider.setLastArticleId(article.articleId);
    setState(() {
      _a = article;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    // print(widget.loadArticleScreenId);
    return _isLoading
        ? CircularProgressIndicator()
        : _a != null
            ? ArticleScreen(
                id: _a.articleId,
                title: _a.title,
                description: _a.description,
                imageUrl: _a.imageUrl,
                pubDate: _a.pubDate,
                source: _a.source,
                category: _a.category,
                link: _a.link)
            : Container();
  }
}
