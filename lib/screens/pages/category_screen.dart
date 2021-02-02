import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/category.dart';
import 'package:newheadline/screens/pages/articles_screen.dart';
import 'package:newheadline/shared/app_drawer.dart';
import 'package:newheadline/utils/auth.dart';
import 'package:newheadline/widgets/category_item.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = '/category';

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  var _isInit = true;
  var _isLoading = false;
  List<Category> categories = [];
  List<Article> articles = [];
  // List<Article> categorizedArticle = [];
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
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      CategoryProvider cProvider = Provider.of<CategoryProvider>(context);
      ArticleProvider aProvider = Provider.of<ArticleProvider>(context);
      aProvider.fetchArticles().then((_) {
        setState(() {
          articles = aProvider.items;
        });
      });

      cProvider.fetchCategories().then((_) {
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

  void filterCategory(String categoryName) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    aProvider.filterByCategory(categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          centerTitle: true,
          bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.black,
              onTap: (int index) {
                filterCategory(categoryNames[index]);
              },
              tabs: categories
                  .map(
                    (Category c) => Tab(
                      text:
                          ('${c.categoryName[0].toUpperCase()}${c.categoryName.substring(1)}'),
                    ),
                  )
                  .toList()),
          title: Text('All news'),
        ),
        body: TabBarView(
            controller: _tabController,
            children: categories
                .map(
                  (Category c) => Tab(
                    child: ArticlesScreen(),
                  ),
                )
                .toList()),
      ),
    );
  }
}
