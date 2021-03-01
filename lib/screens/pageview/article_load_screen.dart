import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/screens/pages/article_screen.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';
import 'package:provider/provider.dart';

class ArticleLoadScreen extends StatefulWidget {
  @override
  _ArticleLoadScreenState createState() => _ArticleLoadScreenState();
}

class _ArticleLoadScreenState extends State<ArticleLoadScreen> {
  bool _isLoading = false;
  Article _a;

  @override
  void initState() {
    super.initState();
    _fetchArticle();
  }

  void _fetchArticle() async {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    setState(() {
      _isLoading = true;
    });
    Map<String, dynamic> data = await APIService().getOne(
        "$ARTICLE_URL/?article_id=${aProvider.lastArticleId}&category=${aProvider.getFilteredCategory}");
    Article article = Article.fromJson(data);
    aProvider.setLastArticleId(article.articleId);
    setState(() {
      _a = article;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
