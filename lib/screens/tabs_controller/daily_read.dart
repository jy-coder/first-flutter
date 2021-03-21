import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/all_article/articles_screen.dart';
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
    ThemeProvider tProvider = Provider.of<ThemeProvider>(context, listen: true);
    return Container(child: Text("I am subscribed"));
  }
}
