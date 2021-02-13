import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';
import 'package:newheadline/widgets/search_bar.dart';

class SearchScreen extends StatefulWidget {
  static final routeName = "searchScreen";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _search = "";
  bool reload = false;
  List<SearchSuggestion> suggestions = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _fetchSearchSuggestions();
    super.didChangeDependencies();
  }

  void _fetchSearchSuggestions() async {
    List<Map<String, dynamic>> result =
        await APIService().get("$SEARCH_SUGGESTION_URL/?q=$_search");

    List<SearchSuggestion> temp = [];

    for (Map<String, dynamic> r in result) {
      temp.add(SearchSuggestion.fromJson(r));
    }

    setState(() {
      suggestions = temp;
    });

    // print(suggestions);
  }

  void searchInput(String searchInput) {
    setState(() {
      _search = searchInput;
    });
    didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(child: SearchBar(searchInput: searchInput)),
        ),
        body: Container());
  }
}
