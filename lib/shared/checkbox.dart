import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/provider.dart';
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
                    'Check',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async => {
                    _saveForm()
                    // print(checkBoxes)
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
