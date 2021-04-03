import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/utils/common.dart';
import 'package:provider/provider.dart';

class CheckBox extends StatefulWidget {
  final bool edit;
  final Function refreshSubscription;
  final Map<String, bool> checkboxes;
  final List<Subscription> categories;
  CheckBox(
      {this.edit, this.refreshSubscription, this.checkboxes, this.categories});
  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider tProvider = Provider.of<ThemeProvider>(context, listen: true);
    return Container(
      child: RefreshIndicator(
          onRefresh: () => widget.refreshSubscription(context),
          child: ListView(
            children: [
              Column(
                  children: widget.categories.sublist(1).map((Subscription c) {
                String cId = c.categoryId.toString();
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: CheckboxListTile(
                    activeColor: tProvider.theme == "light"
                        ? Colors.black54
                        : Colors.white,
                    checkColor: tProvider.theme == "light"
                        ? Colors.white
                        : Colors.black54,
                    title: Text(
                      capitalize(c.categoryName)
                    ),
                    value: widget.checkboxes[cId],
                    onChanged: !widget.edit
                        ? null
                        : (bool value) {
                            setState(() {
                              widget.checkboxes[cId] = !widget.checkboxes[cId];
                            });
                          },
                  ),
                );
              }).toList()),
            ],
          )),
    );
  }
}
