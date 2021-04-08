import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/search.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/authenticate/authenticate.dart';
import 'package:newheadline/screens/all_article/articles.dart';
import 'package:newheadline/screens/search/search_screen.dart';
import 'package:provider/provider.dart';

class NoAuthScreen extends StatefulWidget {
  @override
  _NoAuthScreenState createState() => _NoAuthScreenState();
}

class _NoAuthScreenState extends State<NoAuthScreen> {
  final List<Map<String, Object>> _pages = [
    {
      'page': ArticlesTab(),
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

  @override
  void initState() {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    aProvider.setTab("all_articles");

    super.initState();
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);

    if (_selectedPageIndex == index) return;
    aProvider.setTab(_pages[index]['title']);

    if (_pages[index]['title'] == "Search") {
      aProvider.emptyItems();
    }

    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider tProvider = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor:
            tProvider.theme == "light" ? Colors.black54 : Colors.grey,
        selectedItemColor:
            tProvider.theme == "light" ? Colors.blue : Colors.green,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chrome_reader_mode_outlined),
            label: 'Articles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
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
