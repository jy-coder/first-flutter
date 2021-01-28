import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/provider.dart';
import 'package:newheadline/shared/alert_box.dart';
import 'package:newheadline/utils/auth.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/url.dart';
import 'package:provider/provider.dart';

class CheckBox extends StatefulWidget {
  final bool edit;
  final Function updateSubscription;
  final Function refreshSubscription;
  final Map<String, bool> checkboxes;
  final List<Category> categories;
  CheckBox(
      {this.edit,
      this.refreshSubscription,
      this.updateSubscription,
      this.checkboxes,
      this.categories});
  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: RefreshIndicator(
          onRefresh: () => widget.refreshSubscription(context),
          child: ListView(
            children: [
              Column(
                  children: widget.categories.map((Category c) {
                String cId = c.id.toString();
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: CheckboxListTile(
                    title: Text(c.categoryName),
                    value: widget.checkboxes[cId],
                    onChanged: !widget.edit
                        ? null
                        : (bool value) {
                            // print(checkboxes);
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
