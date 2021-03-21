import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/search.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/tabs_controller/articles.dart';
import 'package:newheadline/screens/home/recommend1.dart';
import 'package:newheadline/screens/profile/profile_screen.dart';
import 'package:newheadline/screens/reading_list/reading_list.dart';
import 'package:newheadline/screens/search/search_screen.dart';
import 'package:newheadline/screens/home/home.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _selectedPageIndex = 0;
  final List<Map<String, Object>> _pages = [
    {
      'page': HomeTab(),
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
    if (_selectedPageIndex == index) return;
    aProvider.setTab(_pages[index]['title']);

    if (_pages[index]['title'] == "reading_list") {
      aProvider.setSubTab("Saved");
      aProvider.setFilteredDate("");
    } else if (_pages[index]['title'] == "Search") {
      sProvider.emptyItems();
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
        unselectedItemColor:
            tProvider.theme == "light" ? Colors.black54 : Colors.grey,
        selectedItemColor:
            tProvider.theme == "light" ? Colors.blue : Colors.green,
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
