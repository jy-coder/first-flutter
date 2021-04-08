import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/authenticate/auth_screen.dart';
import 'package:newheadline/screens/home/display_screen.dart';
import 'package:newheadline/shared/textstyle.dart';
import 'package:newheadline/widgets/date_filter.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  static const routeName = '/hometab';

  final List<Category> categories;

  HomeTab({this.categories});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  var _isLoading = false;
  List<Article> articles = [];
  TabController _tabController;
  List<String> categoryNames = [];
  List<String> homeTab = ["For You", "Trending"];

  @override
  void initState() {
    super.initState();
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    _tabController = TabController(vsync: this, length: homeTab.length);
    aProvider.fetchBookmarkId();
    aProvider.fetchLikekId();
  }

  @override
  void dispose() {
    if (_tabController != null) _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider tProvider = Provider.of<ThemeProvider>(context, listen: true);
    ArticleProvider hProvider =
        Provider.of<ArticleProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Filter(),
        ],
      ),
      body: !_isLoading
          ? TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: homeTab
                  .map(
                    (String tabName) => Tab(
                      child: DisplayScreen(displayTabName: tabName),
                    ),
                  )
                  .toList(),
            )
          : Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
              ),
            ),
    );
  }
}
