import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/utils/load_image.dart';
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
  bool _hasMore = true;
  bool _init = false;
  List<String> filterValues = [];
  String selectedValue = "";
  bool refresh = false;

  @override
  void initState() {
    // print("init called");
    super.initState();
    _isLoading = true;
    _hasMore = true;
    _init = true;
    // print("init triggered");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMore();

      // print("mounted value:$mounted");
    });
  }

  @override
  void didChangeDependencies() {
    // print("dependency changed");
    super.didChangeDependencies();
    _isLoading = true;
    _hasMore = true;
    if (!_init) _loadMore();
    _init = false;
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

    aProvider.fetchBookmark().then((result) async {
      await Future.wait(aProvider.bookmarkItems
          .map((a) =>
              Utils.cacheImage(context, a.imageUrl, a.articleId.toString()))
          .toList());

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
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: true);
    List<Article> bookmarkItems = aProvider.bookmarkItems;
    return Scaffold(
      body: ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: _hasMore ? bookmarkItems.length + 1 : bookmarkItems.length,
          itemBuilder: (ctx, i) {
            // print(bookmarkItems[i].historyDate);
            // Don't trigger if one async loading is already under way
            if (i >= bookmarkItems.length) {
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
