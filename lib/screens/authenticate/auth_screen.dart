import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/all_article/articles.dart';
import 'package:newheadline/screens/home/trend_screen.dart';
import 'package:newheadline/screens/profile/profile_screen.dart';
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
      'page': TrendScreen(),
      'title': 'trend',
    },
    {
      'page': ProfileScreen(),
      'title': 'Setting',
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

    if (_selectedPageIndex == index) return;
    aProvider.setTab(_pages[index]['title']);

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
            label: 'For You',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chrome_reader_mode_outlined),
            label: "Headlines",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: "Trend",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
