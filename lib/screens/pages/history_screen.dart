import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/shared/app_drawer.dart';
import 'package:newheadline/utils/date.dart';
import 'package:newheadline/utils/load_image.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/widgets/article_card.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  static const routeName = "/history";

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _isLoading = true;
  bool _hasMore = true;
  List<String> filterOptions = [];
  List<String> filterValues = [];
  String selectedValue;

  @override
  void initState() {
    // print("init called");
    super.initState();
    _isLoading = true;
    _hasMore = true;

    Map<String, String> dates = getRangeOfDate();
    filterOptions = dates.values.toList();
    filterValues = dates.keys.toList();

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

    aProvider.fetchReadingHistory().then((result) async {
      await Future.wait(aProvider.historyItems
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
        Provider.of<ArticleProvider>(context, listen: false);
    List<Article> historyItems = aProvider.historyItems;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reading History'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt_sharp),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (builder) {
                    return StatefulBuilder(builder: (BuildContext context,
                        StateSetter setState /*You can rename this!*/) {
                      return Container(
                        child: Column(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {},
                                      child: Text("Clear"),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text("Filter"),
                                    ),
                                  ],
                                )),
                            Expanded(
                              flex: 8,
                              child: ListView.builder(
                                  itemCount: filterOptions.length,
                                  itemBuilder: (context, index) {
                                    return RadioListTile(
                                        title: Text(filterOptions[index]),
                                        value: filterValues[index],
                                        groupValue: selectedValue,
                                        onChanged: (String val) {
                                          setState(() {
                                            selectedValue = val;
                                          });
                                        });
                                  }),
                            ),
                          ],
                        ),
                      );
                    });
                  });
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: _hasMore ? historyItems.length + 1 : historyItems.length,
          itemBuilder: (ctx, i) {
            // print(historyItems[i].historyDate);
            // Don't trigger if one async loading is already under way
            if (i >= historyItems.length) {
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
              historyItems[i].articleId,
              historyItems[i].title,
              historyItems[i].imageUrl,
              historyItems[i].summary,
              historyItems[i].link,
              historyItems[i].description,
              historyItems[i].pubDate,
              historyItems[i].source,
              historyItems[i].category,
            );
          }),
    );
  }
}
