import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/home/display_screen.dart';
import 'package:newheadline/shared/textstyle.dart';
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
    _tabController = TabController(vsync: this, length: homeTab.length);
  }

  @override
  void dispose() {
    if (_tabController != null) _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider tProvider = Provider.of<ThemeProvider>(context, listen: true);
    return DefaultTabController(
      length: homeTab.length,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 60),
            child: !_isLoading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TabBar(
                        indicatorColor: tProvider.theme == "light"
                            ? Colors.blue
                            : Colors.green,
                        controller: _tabController,
                        isScrollable: true,
                        tabs: homeTab
                            .map(
                              (String tabName) => Tab(
                                  child: Text(
                                tabName,
                                style: CustomTextStyle.normalBold(
                                    context, tProvider.fontSize),
                              )),
                            )
                            .toList(),
                      ),
                    ],
                  )
                : null,
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
        ),
      ),
    );
  }
}