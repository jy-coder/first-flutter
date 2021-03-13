import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/category.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/pages/articles_screen.dart';
import 'package:newheadline/shared/textstyle.dart';
import 'package:provider/provider.dart';

class DailyReadTab extends StatefulWidget {
  static const routeName = '/DailyPageView';

  final List<Category> categories;

  DailyReadTab({this.categories});

  @override
  _DailyReadTabState createState() => _DailyReadTabState();
}

class _DailyReadTabState extends State<DailyReadTab>
    with SingleTickerProviderStateMixin {
  var _isLoading = false;
  List<Article> articles = [];
  TabController _tabController;
  List<String> categoryNames = [];

  @override
  void initState() {
    super.initState();
    if (widget.categories.isNotEmpty)
      _tabController =
          TabController(vsync: this, length: widget.categories.length);
  }

  @override
  void dispose() {
    if (_tabController != null) _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    CategoryProvider cProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    ThemeProvider tProvider = Provider.of<ThemeProvider>(context, listen: true);
    return DefaultTabController(
      length: widget.categories.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          bottom: !_isLoading
              ? TabBar(
                  indicatorColor:
                      tProvider.theme == "light" ? Colors.blue : Colors.green,
                  controller: _tabController,
                  isScrollable: true,
                  onTap: (int index) {
                    aProvider.filterByCategory(
                      cProvider.categoryNames[index],
                    );
                  },
                  tabs: widget.categories
                      .map(
                        (Category c) => Tab(
                            child: Text(
                          '${c.categoryName[0].toUpperCase()}${c.categoryName.substring(1)}',
                          style: CustomTextStyle.normalBold(
                              context, tProvider.fontSize),
                        )),
                      )
                      .toList(),
                )
              : null,
          title: Text('Daily Read'),
        ),
        body: !_isLoading
            ? TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: widget.categories
                    .map(
                      (Category c) => Tab(
                        child: ArticlesScreen(),
                      ),
                    )
                    .toList(),
              )
            : Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                ),
              ),
      ),
    );
  }
}
