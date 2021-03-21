import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/category.dart';
import 'package:newheadline/provider/search.dart';
import 'package:newheadline/provider/subscription.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/authenticate/authenticate.dart';
import 'package:newheadline/screens/all_article/articles_screen.dart';
import 'package:newheadline/screens/reading_list/bookmark_screen.dart';
import 'package:newheadline/screens/tabs_controller/articles.dart';
import 'package:newheadline/screens/reading_list/history_screen.dart';
import 'package:newheadline/screens/authenticate/home_screen.dart';
import 'package:newheadline/screens/reading_list/reading_list.dart';
import 'package:newheadline/screens/search/search_screen.dart';
import 'package:newheadline/screens/single_article/article_pageview.dart';
import 'package:newheadline/screens/profile/subscription_setting_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newheadline/screens/single_article/search_pageview.dart';
import 'package:newheadline/provider/auth.dart';
import 'package:newheadline/screens/home/display_screen.dart';
import 'package:newheadline/shared/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: Auth()),
      ChangeNotifierProvider.value(value: CategoryProvider()),
      ChangeNotifierProvider.value(value: ArticleProvider()),
      ChangeNotifierProvider.value(value: SubscriptionProvider()),
      ChangeNotifierProvider.value(value: SearchProvider()),
      ChangeNotifierProvider.value(value: ThemeProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _getStorage();
  }

  Future<void> _getStorage() async {
    ThemeProvider tProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    await tProvider.getStorage();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider tProvider = Provider.of<ThemeProvider>(context, listen: true);
    return StreamProvider.value(
      value: Auth().user,
      child: MaterialApp(
          title: 'NewsHeadline',
          theme: ThemeData(
            primarySwatch: white,
            brightness: Brightness.light,
          ),
          themeMode:
              tProvider.theme == "dark" ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),
          home: HomeScreen(),
          routes: {
            ArticlePageViewScreen.routeName: (ctx) => ArticlePageViewScreen(),
            ArticlesTab.routeName: (ctx) => ArticlesTab(),
            ArticlesScreen.routeName: (ctx) => ArticlesScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            SubscriptionScreen.routeName: (ctx) => SubscriptionScreen(),
            Authenticate.routeName: (ctx) => Authenticate(),
            HistoryScreen.routeName: (ctx) => HistoryScreen(),
            ReadListScreen.routeName: (ctx) => ReadListScreen(),
            BookmarkScreen.routeName: (ctx) => BookmarkScreen(),
            SearchScreen.routeName: (ctx) => SearchScreen(),
            SearchPageViewScreen.routeName: (ctx) => SearchPageViewScreen(),
            DisplayScreen.routeName: (ctx) => DisplayScreen(),
          }),
    );
  }
}
