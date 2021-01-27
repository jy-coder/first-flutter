import 'package:flutter/material.dart';
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
  Map<int, bool> checkboxes = {};
  List<Category> categories = [];
  final _formKey = GlobalKey<FormState>();
  String _token = "";

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
          Provider.of<CategoryProvider>(context, listen: false);

      Auth aProvider = Provider.of<Auth>(context, listen: true);
      aProvider.getToken().then((String token) {
        setState(() {
          _token = token;
        });
      });

      provider.fetchCategories().then((_) {
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

  // void _saveCategory() {
  //   Auth aProvider = Provider.of<Auth>(context, listen: false);
  //   aProvider.currentUser.getIdToken().then((result) {
  //     setState(() {});
  //   });
  // }

  void _saveForm() {
    _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                    children: categories.map((Category c) {
                  return CheckboxListTile(
                    title: Text(c.categoryName),
                    value: checkboxes[c.categoryId],
                    onChanged: (bool value) {
                      print(checkboxes);
                      setState(() {
                        checkboxes[c.categoryId] = !checkboxes[c.categoryId];
                      });
                    },
                  );
                }).toList()),
                RaisedButton(
                  child: Text(
                    'Save Preference',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async => {
                    post(SET_CATEGORY, _token, {"test": "test"})
                    // print(checkboxes)
                    // print(categories)
                    // print(values);
                  },
                ),
              ],
            )),
      ),
    );
  }
}
