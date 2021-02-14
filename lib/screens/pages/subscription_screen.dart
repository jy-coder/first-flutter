import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/shared/app_drawer.dart';

class SubscriptionScreen extends StatefulWidget {
  static const routeName = '/Subscription';

  final List<Subscription> categories;

  SubscriptionScreen({this.categories});

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen>
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
    return DefaultTabController(
      length: widget.categories.length,
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
                  tabs: widget.categories
                      .map(
                        (Subscription c) => Tab(
                          text:
                              ('${c.categoryName[0].toUpperCase()}${c.categoryName.substring(1)}'),
                        ),
                      )
                      .toList(),
                )
              : null,
          title: Text('Daily Read'),
        ),
        body: !_isLoading
            ? TabBarView(
                controller: _tabController,
                children: widget.categories
                    .map(
                      (Subscription c) => Tab(
                        child: Container(
                          child: Text(
                            c.categoryName.toString(),
                          ),
                        ),
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
