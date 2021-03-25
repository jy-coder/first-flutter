import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/auth.dart';
import 'package:newheadline/provider/category.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/all_article/articles_screen.dart';
import 'package:newheadline/shared/textstyle.dart';
import 'package:provider/provider.dart';

class ArticlesTab extends StatefulWidget {
  static const routeName = '/category';

  @override
  _ArticlesTabState createState() => _ArticlesTabState();
}

class _ArticlesTabState extends State<ArticlesTab>
    with SingleTickerProviderStateMixin {
  var _isInit = true;
  var _isLoading = false;
  List<Category> categories = [];
  List<Article> articles = [];
  TabController _tabController;
  List<String> categoryNames = [];

  @override
  void initState() {
    super.initState();
    if (categories.length != 0)
      _tabController = TabController(vsync: this, length: categories.length);
  }

  @override
  void dispose() {
    if (_tabController != null) _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      CategoryProvider cProvider =
          Provider.of<CategoryProvider>(context, listen: false);
      Auth auProvider = Provider.of<Auth>(context, listen: false);

      cProvider.fetchCategories(auProvider.token).then((_) {
        setState(() {
          _isLoading = false;
          categories = cProvider.items;
          categoryNames = cProvider.categoryNames;
        });
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    ThemeProvider tProvider = Provider.of<ThemeProvider>(context, listen: true);
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          bottom: !_isLoading
              ? TabBar(
                  indicatorColor:
                      tProvider.theme == "light" ? Colors.blue : Colors.green,
                  controller: _tabController,
                  isScrollable: true,
                  unselectedLabelColor: Colors.blue,
                  onTap: (int index) {
                    aProvider.setCategory(
                      categoryNames[index],
                    );
                  },
                  tabs: categories
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
          title: Text('All news'),
        ),
        body: !_isLoading
            ? TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: categories
                    .map(
                      (Category c) => Tab(
                        child: ArticlesScreen(categoryName: c.categoryName),
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
