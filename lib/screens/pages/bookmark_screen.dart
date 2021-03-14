import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/widgets/article_card.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatefulWidget {
  static const routeName = "/bookmark";

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  bool _isLoading = true;
  List<String> filterValues = [];
  String selectedValue = "";
  bool refresh = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;

    _loadBookMark();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isLoading = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _loadBookMark() async {
    if (!mounted) return;
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);

    setState(() {
      _isLoading = true;
    });
    await aProvider.fetchBookmark();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: true);
    List<Article> bookmarkItems = aProvider.items;
    return _isLoading
        ? CircularProgressIndicator(
            backgroundColor: Colors.grey,
          )
        : Scaffold(
            body: ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: bookmarkItems.length,
                itemBuilder: (ctx, i) {
                  return ArticleCard(
                      bookmarkItems[i].articleId,
                      bookmarkItems[i].title,
                      bookmarkItems[i].imageUrl,
                      bookmarkItems[i].summary,
                      bookmarkItems[i].link,
                      bookmarkItems[i].description,
                      bookmarkItems[i].pubDate,
                      bookmarkItems[i].source,
                      bookmarkItems[i].category,
                      bookmarkItems[i].historyDate);
                }),
          );
  }
}
