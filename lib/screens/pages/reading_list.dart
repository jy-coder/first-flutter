import 'package:flutter/material.dart';
import 'package:newheadline/screens/pages/history_screen.dart';
import 'package:newheadline/shared/app_drawer.dart';
import 'package:newheadline/widgets/date_filter.dart';

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          centerTitle: true,
          bottom: !_isLoading
              ? TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: Colors.black,
                  onTap: (int index) {},
                  tabs: readingList
                      .map(
                        (tabname) => Tab(
                          text: (tabname),
                        ),
                      )
                      .toList(),
                )
              : null,
          title: Container(
              child: Row(
            children: [
              Container(
                child: Text('Reading List'),
              ),
              Spacer(),
              Container(
                child: Filter(),
              ),
            ],
          )),
        ),
        body: !_isLoading
            ? TabBarView(
                controller: _tabController,
                children: readingList
                    .map(
                      (String rl) => Tab(
                        child: HistoryScreen(),
                      ),
                    )
                    .toList(),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
