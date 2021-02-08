import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';

class CheckBox extends StatefulWidget {
  final bool edit;
  final Function updateSubscription;
  final Function refreshSubscription;
  final Map<String, bool> checkboxes;
  final List<Subscription> categories;
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
      child: RefreshIndicator(
          onRefresh: () => widget.refreshSubscription(context),
          child: ListView(
            children: [
              Column(
                  children: widget.categories.map((Subscription c) {
                String cId = c.categoryId.toString();
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: CheckboxListTile(
                    title: Text(c.categoryName),
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
