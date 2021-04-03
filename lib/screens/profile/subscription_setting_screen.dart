import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/subscription.dart';
import 'package:newheadline/screens/profile/checkbox.dart';

import 'package:provider/provider.dart';

class SubscriptionScreen extends StatefulWidget {
  static const routeName = "/settings";

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

  void toggleButton() {
    setState(() => edit = !edit);
  }

  void refreshSubscription(BuildContext context) async {
    _isInit = true;
    didChangeDependencies();
  }

  Future<void> updateSetting(BuildContext context) async {
    SubscriptionProvider sProvider =
        Provider.of<SubscriptionProvider>(context, listen: false);
    int responseCode = await sProvider.updateSubscription(checkboxes);

    Flushbar(
      message: responseCode == 500
          ? "Error updating"
          : responseCode == 200
              ? "Successfully update"
              : null,
      duration: Duration(seconds: 3),
      isDismissible: false,
    )..show(context);

    if (responseCode == 200) {
      toggleButton();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Subscription",
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
                          await updateSetting(context);
                        }),
                    TextButton(
                        child: Text("Cancel"),
                        style: TextButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        onPressed: () {
                          refreshSubscription(context);
                          toggleButton();
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
                      checkboxes: checkboxes,
                      categories: categories,
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                  )),
          ],
        ),
      ),
      // drawer: args == "settings" ? AppDrawer() : null,
    );
  }
}
