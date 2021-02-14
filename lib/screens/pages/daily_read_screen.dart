import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/search.dart';
import 'package:newheadline/provider/subscription.dart';
import 'package:newheadline/screens/pages/search_screen.dart';
import 'package:newheadline/screens/pages/setting_screen.dart';
import 'package:newheadline/screens/pages/subscription_screen.dart';
import 'package:newheadline/shared/app_drawer.dart';
import 'package:newheadline/shared/textstyle.dart';
import 'package:provider/provider.dart';

class DailyReadScreen extends StatefulWidget {
  @override
  _DailyReadScreenState createState() => _DailyReadScreenState();
}

class _DailyReadScreenState extends State<DailyReadScreen> {
  var _isInit = true;
  var _isLoading = false;

  List<Subscription> categories = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      SubscriptionProvider cProvider =
          Provider.of<SubscriptionProvider>(context, listen: true);

      cProvider.fetchSubscriptionCategory().then((_) {
        setState(() {
          _isLoading = false;
          categories = cProvider.subscriptionCategory;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SearchProvider sProvider =
        Provider.of<SearchProvider>(context, listen: false);

    Provider.of<SubscriptionProvider>(context, listen: true);

    return !_isLoading && categories.isEmpty
        ? Scaffold(
            appBar: AppBar(
              title: Container(
                child: Row(
                  children: [
                    Text('Daily Read'),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        sProvider.emptyItems();
                        Navigator.pushNamed(
                          context,
                          SearchScreen.routeName,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            drawer: AppDrawer(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Text("Personalize Your Feed",
                        style: CustomTextStyle.smallbold(context)),
                  ),
                  Container(
                    child: FlatButton.icon(
                      color: Colors.green[600],
                      label: Text(
                        "Customize",
                        style: CustomTextStyle.whitesmall(context),
                      ),
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          SettingScreen.routeName,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : SubscriptionScreen(categories: categories);
  }
}
