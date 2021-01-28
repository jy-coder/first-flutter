import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/provider.dart';
import 'package:newheadline/utils/auth.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/url.dart';
import 'package:provider/provider.dart';

class CheckBox extends StatefulWidget {
  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  var _isInit = true;
  var _isLoading = false;
  Map<String, bool> checkboxes = {};
  List<Category> categories = [];
  final _formKey = GlobalKey<FormState>();

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

      CategoryProvider provider =
          Provider.of<CategoryProvider>(context, listen: true);

      provider.fetchCategories().then((_) {
        print("reest");
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

  void _updateSubscription(context) async {
    int responseCode = await APIService().post(SUBSCRIPTION, checkboxes);
    print(responseCode);
    if (responseCode == 500) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                  content: Text("Something went wrong"),
                  actions: <Widget>[
                    FlatButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        })
                  ]));
    }
  }

  Future<void> _refreshSubscription(BuildContext context) async {
    print("refrshing");
    await Provider.of<CategoryProvider>(context, listen: false)
        .fetchCategories();
    _isInit = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: RefreshIndicator(
          onRefresh: () => _refreshSubscription(context),
          child: ListView(
            children: [
              Column(
                  children: categories.map((Category c) {
                String cId = c.id.toString();
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: CheckboxListTile(
                    title: Text(c.categoryName),
                    value: checkboxes[cId],
                    onChanged: (bool value) {
                      // print(checkboxes);
                      setState(() {
                        checkboxes[cId] = !checkboxes[cId];
                      });
                    },
                  ),
                );
              }).toList()),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: RaisedButton(
                      child: Text(
                        'Save Preference',
                        // style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async => {_updateSubscription(context)},
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
