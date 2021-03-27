import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/shared/constants.dart';
import 'package:provider/provider.dart';

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
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: true);
    return Container(
      child: Form(
        key: _formKey,
        child: TextFormField(
          textInputAction: TextInputAction.search,
          decoration: searchInputDecoration.copyWith(
            hintText: 'Enter Your Search',
          ),
          onChanged: (val) {
            // widget.searchInput(val);
          },
          onFieldSubmitted: (val) async {
            aProvider.emptyItems();
            await aProvider.fetchSearchResults(val);
            // widget.searchSubmit(val);
          },
        ),
      ),
    );
  }
}
