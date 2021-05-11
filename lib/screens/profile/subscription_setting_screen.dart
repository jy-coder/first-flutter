import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/subscription.dart';
import 'package:newheadline/screens/profile/checkbox.dart';
import 'package:newheadline/utils/common.dart';

import 'package:provider/provider.dart';

class SubscriptionScreen extends StatefulWidget {
  static const routeName = "/subscription-settings";

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool edit = false;
  var _isInit = true;
  bool _isLoading = false;
  Map<String, bool> checkboxes = {};
  List<Subscription> categories = [];

  @override
  void didChangeDependencies() {
    if (!mounted) return;
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      SubscriptionProvider provider =
          Provider.of<SubscriptionProvider>(context, listen: false);

      provider.fetchSubscriptionSetting().then((_) {
        setState(() {
          checkboxes = provider.checkboxes;
          categories = provider.settings;
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  void refreshSubscription(BuildContext context) async {
    _isInit = true;
    didChangeDependencies();
  }

  Future<void> updateSetting(BuildContext context) async {
    SubscriptionProvider sProvider =
        Provider.of<SubscriptionProvider>(context, listen: false);
    sProvider.updateSubscription(checkboxes);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await updateSetting(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "",
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 5),
          child: Column(
            children: [
              !_isLoading
                  ? Expanded(
                      child: CheckBox(
                        refreshSubscription: refreshSubscription,
                        checkboxes: checkboxes,
                        categories: categories,
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
