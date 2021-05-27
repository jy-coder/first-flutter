import 'package:flutter/material.dart';
import 'package:newheadline/provider/category.dart';
import 'package:newheadline/provider/subscription.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/profile/subscription_setting_screen.dart';
import 'package:newheadline/screens/home/recommend2.dart';
import 'package:newheadline/shared/textstyle.dart';
import 'package:provider/provider.dart';

class RecommendScreen1 extends StatefulWidget {
  @override
  _RecommendScreen1State createState() => _RecommendScreen1State();
}

class _RecommendScreen1State extends State<RecommendScreen1> {
  var _isLoading = false;

  List<String> categories = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    CategoryProvider cProvider =
        Provider.of<CategoryProvider>(context, listen: true);

    cProvider.fetchSubscriptionCategories().then((_) {
      setState(() {
        categories = cProvider.categoryNames;
        _isLoading = false;
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<SubscriptionProvider>(context, listen: true);

    ThemeProvider tProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
            ),
          )
        : !_isLoading && categories.isNotEmpty
            ? RecommendScreen2()
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
              ));
  }
}
