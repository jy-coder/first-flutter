import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/category.dart';
import 'package:newheadline/provider/search.dart';
import 'package:newheadline/provider/subscription.dart';
import 'package:newheadline/screens/authenticate/authenticate.dart';
import 'package:newheadline/screens/pages/articles_screen.dart';
import 'package:newheadline/screens/pages/bookmark_screen.dart';
import 'package:newheadline/screens/pages/category_screen.dart';
import 'package:newheadline/screens/pages/history_screen.dart';
import 'package:newheadline/screens/pages/home_screen.dart';
import 'package:newheadline/screens/pages/reading_list.dart';
import 'package:newheadline/screens/pages/search_screen.dart';
import 'package:newheadline/screens/pageview/article_pageview.dart';
import 'package:newheadline/screens/pages/subscription_setting_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newheadline/screens/pageview/search_pageview.dart';
import 'package:newheadline/utils/auth.dart';
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
      ChangeNotifierProvider.value(value: SearchProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: Auth().user,
      child: MaterialApp(
          title: 'NewsHeadline',
          theme: new ThemeData(
              appBarTheme: AppBarTheme(
                color: Colors.white,
              ),
              primaryTextTheme: TextTheme(
                headline6: TextStyle(color: Colors.black),
              ),
              primaryIconTheme: IconThemeData(
                color: Colors.black,
              ),
              buttonTheme: ButtonThemeData(
                buttonColor: Colors.black87, //  <-- dark color
                textTheme: ButtonTextTheme
                    .primary, //  <-- this auto selects the right color
              )),
          home: HomeScreen(),
          routes: {
            ArticlePageViewScreen.routeName: (ctx) => ArticlePageViewScreen(),
            CategoryScreen.routeName: (ctx) => CategoryScreen(),
            ArticlesScreen.routeName: (ctx) => ArticlesScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            SubscriptionScreen.routeName: (ctx) => SubscriptionScreen(),
            Authenticate.routeName: (ctx) => Authenticate(),
            HistoryScreen.routeName: (ctx) => HistoryScreen(),
            ReadListScreen.routeName: (ctx) => ReadListScreen(),
            BookmarkScreen.routeName: (ctx) => BookmarkScreen(),
            SearchScreen.routeName: (ctx) => SearchScreen(),
            SearchPageViewScreen.routeName: (ctx) => SearchPageViewScreen(),
          }),
    );
  }
}
