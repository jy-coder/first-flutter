import 'package:flutter/material.dart';
import 'package:newheadline/provider/search.dart';
import 'package:newheadline/screens/pages/search_screen.dart';
import 'package:newheadline/shared/app_drawer.dart';
import 'package:provider/provider.dart';

class DailyReadScreen extends StatefulWidget {
  @override
  _DailyReadScreenState createState() => _DailyReadScreenState();
}

class _DailyReadScreenState extends State<DailyReadScreen> {
  @override
  Widget build(BuildContext context) {
    SearchProvider sProvider =
        Provider.of<SearchProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Container(
            child: Row(
              children: [
                Text('Daily Read'),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    sProvider.emptyItems();
                    Navigator.pushNamed(
                      context,
                      SearchScreen.routeName,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        drawer: AppDrawer(),
        body: Text("Empty for now"));
  }
}
