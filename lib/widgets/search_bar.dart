import 'package:flutter/material.dart';
import 'package:newheadline/shared/constants.dart';

class SearchBar extends StatefulWidget {
  Function searchInput;
  SearchBar({this.searchInput});
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: TextFormField(
            decoration: textInputDecoration.copyWith(
              hintText: 'Search ...',
            ),
            onChanged: (val) {
              widget.searchInput(val);
            }),
      ),
    );
  }
}
