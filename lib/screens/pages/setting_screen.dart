import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/subscription.dart';
import 'package:newheadline/shared/app_drawer.dart';
import 'package:newheadline/shared/checkbox.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = "/settings";

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool edit = false;
  var _isInit = true;
  bool _isLoading = false;
  Map<String, bool> checkboxes = {};
  List<Subscription> categories = [];
  // final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      SubscriptionProvider provider =
          Provider.of<SubscriptionProvider>(context, listen: true);

      provider.fetchSubscriptions().then((_) {
        setState(() {
          checkboxes = provider.checkboxes;
          categories = provider.items;
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

  void toggleButton() {
    setState(() => edit = !edit);
  }

  Future<void> refreshSubscription(BuildContext context) async {
    await Provider.of<SubscriptionProvider>(context, listen: false)
        .fetchSubscriptions();
    _isInit = true;
  }

  Future<void> updateSubscription(context) async {
    int responseCode = await APIService().post(SUBSCRIPTION_URL, checkboxes);

    Flushbar(
      message: responseCode == 500
          ? "Error updating"
          : responseCode == 200
              ? "Successfully update"
              : null,
      duration: Duration(seconds: 3),
      isDismissible: false,
    )..show(context);

    if (responseCode == 200) toggleButton();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Settings",
            ),
            actions: <Widget>[
              !edit
                  ? IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => toggleButton(),
                    )
                  : Row(children: [
                      IconButton(
                          icon: Icon(Icons.save),
                          onPressed: () async {
                            await updateSubscription(context);
                          }),
                      TextButton(
                          child: Text("Cancel"),
                          onPressed: () async {
                            toggleButton();
                            await refreshSubscription(context);
                          })
                    ])
            ]),
        body: Container(
          padding: EdgeInsets.only(top: 5),
          child: Column(
            children: [
              !_isLoading
                  ? Expanded(
                      child: CheckBox(
                        edit: edit,
                        refreshSubscription: refreshSubscription,
                        updateSubscription: updateSubscription,
                        checkboxes: checkboxes,
                        categories: categories,
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
        drawer: AppDrawer());
  }
}
