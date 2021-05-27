import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/category.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/all_article/articles_screen.dart';
import 'package:newheadline/screens/search/search_screen.dart';
import 'package:newheadline/shared/textstyle.dart';
import 'package:newheadline/utils/common.dart';
import 'package:provider/provider.dart';

class ArticlesTab extends StatefulWidget {
  static const routeName = '/category';

  @override
  _ArticlesTabState createState() => _ArticlesTabState();
}

class _ArticlesTabState extends State<ArticlesTab>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  List<Category> categories = [];
  List<Article> articles = [];
  TabController _tabController;
  List<String> categoryNames = [];

  @override
  void initState() {
    super.initState();

    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);

    fetchCategoryAndArticles();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      aProvider.setCategory = "all";
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void fetchCategoryAndArticles() async {
    CategoryProvider cProvider =
        Provider.of<CategoryProvider>(context, listen: false);

    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);

    await cProvider.fetchCategories().then((_) {
      setState(() {
        categories = cProvider.items;
        categoryNames = cProvider.categoryNames;
      });
      _tabController =
          TabController(vsync: this, length: cProvider.items.length)
            ..addListener(() {
              if (_tabController.indexIsChanging) {
              } else {
                aProvider.setCategory = categoryNames[_tabController.index];
              }
            });
      aProvider.setCategories = cProvider.categoryNames;
    });

    await aProvider.fetchAll();

    setState(() {
      _isLoading = false;
    });
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
          title: Text("Headlines"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              onPressed: () {
                ArticleProvider aProvider =
                    Provider.of<ArticleProvider>(context, listen: false);
                aProvider.emptySearch();
                Navigator.of(context).pushNamed(
                  SearchScreen.routeName,
                );
              },
            )
          ],
          bottom: !_isLoading
              ? TabBar(
                  indicatorColor:
                      tProvider.theme == "light" ? Colors.blue : Colors.green,
                  controller: _tabController,
                  isScrollable: true,
                  unselectedLabelColor: Colors.blue,
                  onTap: (int index) {
                    aProvider.setCategory = categoryNames[index];
                  },
                  tabs: categories
                      .map(
                        (Category c) => Tab(
                            child: Text(
                          capitalize(c.categoryName),
                          style: CustomTextStyle.normalBold(
                              context, tProvider.fontSize),
                        )),
                      )
                      .toList(),
                )
              : null,
        ),
        body: !_isLoading
            ? TabBarView(
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
