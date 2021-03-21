import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/screens/single_article/article_screen.dart';

class ArticleLoadScreen extends StatefulWidget {
  Article article;

  ArticleLoadScreen(this.article);
  @override
  _ArticleLoadScreenState createState() => _ArticleLoadScreenState();
}

class _ArticleLoadScreenState extends State<ArticleLoadScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Article a = widget.article;
    return !_isLoading && a != null
        ? Container(
            child: ArticleScreen(
                id: a.articleId,
                title: a.title,
                description: a.description,
                imageUrl: a.imageUrl,
                pubDate: a.pubDate,
                source: a.source,
                category: a.category,
                link: a.link),
          )
        : Container(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
              ),
            ),
          );
  }
}
