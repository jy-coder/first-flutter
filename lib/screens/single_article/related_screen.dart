import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/single_article/webview_screen.dart';
import 'package:newheadline/shared/textstyle.dart';
import 'package:newheadline/utils/common.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ScreenArguments {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String pubDate;
  final String source;
  final String category;
  final String link;

  ScreenArguments(
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.pubDate,
    this.source,
    this.category,
    this.link,
  );
}

class RelatedScreen extends StatefulWidget {
  final ScreenArguments settings;
  RelatedScreen(this.settings);

  static final routeName = "related-screen";

  @override
  _RelatedScreenState createState() => _RelatedScreenState();
}

Future<void> saveReadingHistory(int articleId) async {
  String url = "$HISTORY_URL/?article=$articleId";
  var result = await APIService().post(url);
}

class _RelatedScreenState extends State<RelatedScreen> {
  List<Article> relatedArticles = [];

  @override
  void didChangeDependencies() {}

  @override
  Widget build(BuildContext context) {
    print(widget.settings.id);
    ThemeProvider tProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(),
    );
  }
}
