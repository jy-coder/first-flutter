import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/category.dart';
import 'package:newheadline/provider/search.dart';
import 'package:newheadline/screens/tabs_controller/articles.dart';
import 'package:newheadline/screens/pages/daily_read_screen.dart';
import 'package:newheadline/screens/pages/profile_screen.dart';
import 'package:newheadline/screens/pages/reading_list.dart';
import 'package:newheadline/screens/pages/search_screen.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _selectedPageIndex = 0;
  final List<Map<String, Object>> _pages = [
    {
      'page': DailyReadScreen(),
      'title': 'daily_read',
    },
    {
      'page': ArticlesTab(),
      'title': 'all_articles',
    },
    {
      'page': ReadListScreen(),
      'title': 'reading_list',
    },
    {
      'page': ProfileScreen(),
      'title': 'Setting',
    },
    {
      'page': SearchScreen(),
      'title': 'Search',
    }
  ];
  @override
  void initState() {
    super.initState();
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    aProvider.setTab("daily_read");
  }

  void _selectPage(int index) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    SearchProvider sProvider =
        Provider.of<SearchProvider>(context, listen: false);

    aProvider.setTab(_pages[index]['title']);

    if (_pages[index]['title'] == "reading_list") {
      aProvider.setSubTab("Saved");
      aProvider.setFilteredDate("");
    } else if (_pages[index]['title'] == "Search") {
      sProvider.emptyItems();
    } else if (_pages[index]['title'] == "daily_read" ||
        _pages[index]['title'] == "all_articles") {
      aProvider.filterByCategory("all");
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
        type: BottomNavigationBarType.fixed,
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_fields),
            label: "All Articles",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Reading List",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Profile",
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
