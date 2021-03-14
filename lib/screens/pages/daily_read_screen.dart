import 'package:flutter/material.dart';
import 'package:newheadline/provider/category.dart';
import 'package:newheadline/provider/subscription.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/pages/subscription_setting_screen.dart';
import 'package:newheadline/screens/tabs_controller/daily_read.dart';
import 'package:newheadline/shared/textstyle.dart';
import 'package:provider/provider.dart';

class DailyReadScreen extends StatefulWidget {
  @override
  _DailyReadScreenState createState() => _DailyReadScreenState();
}

class _DailyReadScreenState extends State<DailyReadScreen> {
  var _isLoading = false;

  List<String> categories = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });

    CategoryProvider cProvider =
        Provider.of<CategoryProvider>(context, listen: true);

    cProvider.fetchSubscriptionCategories().then((_) {
      setState(() {
        _isLoading = false;
        categories = cProvider.categoryNames;
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<SubscriptionProvider>(context, listen: true);
    CategoryProvider cProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    ThemeProvider tProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
              ),
            )
          : !_isLoading && categories.isNotEmpty
              ? DailyReadTab(categories: cProvider.items)
              : Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text("Personalize Your Feed",
                          style: CustomTextStyle.smallbold(
                            context,
                            tProvider.fontSize,
                          )),
                    ),
                    Container(
                      child: FlatButton.icon(
                        color: Colors.green[600],
                        label: Text(
                          "Customize",
                          style: CustomTextStyle.whitesmall(
                              context, tProvider.fontSize),
                        ),
                        icon: Icon(Icons.add),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            SubscriptionScreen.routeName,
                          );
                        },
                      ),
                    ),
                  ],
                )),
    );
  }
}
