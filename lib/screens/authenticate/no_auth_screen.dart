import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/search.dart';
import 'package:newheadline/screens/authenticate/authenticate.dart';
import 'package:newheadline/screens/pages/category_screen.dart';
import 'package:newheadline/screens/pages/search_screen.dart';
import 'package:provider/provider.dart';

class NoAuthScreen extends StatefulWidget {
  @override
  _NoAuthScreenState createState() => _NoAuthScreenState();
}

class _NoAuthScreenState extends State<NoAuthScreen> {
  final List<Map<String, Object>> _pages = [
    {
      'page': CategoryScreen(),
      'title': 'all_articles',
    },
    {
      'page': Authenticate(),
      'title': 'Login',
    },
    {
      'page': SearchScreen(),
      'title': 'Search',
    }
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    SearchProvider sProvider =
        Provider.of<SearchProvider>(context, listen: false);
    aProvider.setTab(_pages[index]['title']);

    if (_pages[index]['title'] == "Search") {
      sProvider.emptyItems();
    }

    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'All articles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          )
        ],
      ),
    );
  }
}
