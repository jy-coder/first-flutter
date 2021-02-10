import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/category.dart';
import 'package:newheadline/provider/subscription.dart';
import 'package:newheadline/screens/authenticate/authenticate.dart';
import 'package:newheadline/screens/pages/article_screen.dart';
import 'package:newheadline/screens/pages/articles_screen.dart';
import 'package:newheadline/screens/pages/category_screen.dart';
import 'package:newheadline/screens/pages/history_screen.dart';
import 'package:newheadline/screens/pages/home_screen.dart';
import 'package:newheadline/screens/pages/reading_list.dart';
import 'package:newheadline/screens/pageview/article_pageview.dart';
import 'package:newheadline/screens/pages/setting_screen.dart';
import 'package:firebase_core/firebase_core.dart';
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
            ArticleScreen.routeName: (ctx) => ArticleScreen(),
            CategoryScreen.routeName: (ctx) => CategoryScreen(),
            ArticlesScreen.routeName: (ctx) => ArticlesScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            SettingScreen.routeName: (ctx) => SettingScreen(),
            Authenticate.routeName: (ctx) => Authenticate(),
            HistoryScreen.routeName: (ctx) => HistoryScreen(),
            ReadListScreen.routeName: (ctx) => ReadListScreen()
          }),
    );
  }
}
