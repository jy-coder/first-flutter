import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/pages/bookmark_screen.dart';
import 'package:newheadline/screens/pages/history_screen.dart';
import 'package:newheadline/shared/textstyle.dart';
import 'package:newheadline/widgets/date_filter.dart';
import 'package:provider/provider.dart';

class ReadListScreen extends StatefulWidget {
  static final routeName = "/readingHistory";
  @override
  _ReadListScreenState createState() => _ReadListScreenState();
}

class _ReadListScreenState extends State<ReadListScreen>
    with SingleTickerProviderStateMixin {
  List<String> readingList = ["Saved", "History"];
  var _isLoading = false;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: readingList.length);
  }

  @override
  void dispose() {
    if (_tabController != null) _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: true);
    ThemeProvider tProvider = Provider.of<ThemeProvider>(context, listen: true);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          bottom: !_isLoading
              ? TabBar(
                  indicatorColor:
                      tProvider.theme == "light" ? Colors.blue : Colors.green,
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: Colors.black,
                  onTap: (int index) {
                    aProvider.setSubTab(readingList[index]);
                  },
                  tabs: readingList
                      .map(
                        (tabname) => Tab(
                          child: Text(
                            tabname,
                            style: CustomTextStyle.normalBold(
                              context,
                              tProvider.fontSize,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )
              : null,
          title: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  'Reading List',
                  textAlign: TextAlign.center,
                ),
              ),
              // Spacer(),
              Container(
                child: aProvider.subTab == "History" ? Filter() : Text(""),
              ),
            ],
          )),
        ),
        body: !_isLoading
            ? TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: readingList.map((String rl) {
                  Widget screen;
                  if (rl == "History")
                    screen = HistoryScreen();
                  else if (rl == "Saved") screen = BookmarkScreen();

                  return Tab(
                    child: screen,
                  );
                }).toList(),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
