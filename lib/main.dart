import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/category.dart';
import 'package:newheadline/provider/subscription.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/authenticate/authenticate.dart';
import 'package:newheadline/screens/all_article/articles_screen.dart';
import 'package:newheadline/screens/authenticate/forget_screen.dart';
import 'package:newheadline/screens/authenticate/reset_screen.dart';
import 'package:newheadline/screens/reading_list/bookmark_screen.dart';
import 'package:newheadline/screens/all_article/articles.dart';
import 'package:newheadline/screens/reading_list/history_screen.dart';
import 'package:newheadline/screens/authenticate/home_screen.dart';
import 'package:newheadline/screens/reading_list/reading_list.dart';
import 'package:newheadline/screens/search/search_screen.dart';
import 'package:newheadline/screens/single_article/article_pageview.dart';
import 'package:newheadline/screens/profile/subscription_setting_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newheadline/provider/auth.dart';
import 'package:newheadline/screens/home/display_screen.dart';
import 'package:newheadline/screens/single_article/related_screen.dart';
import 'package:newheadline/shared/theme.dart';
import 'package:newheadline/utils/urls.dart';
import 'package:newheadline/widgets/category_filter.dart';
import 'package:newheadline/widgets/date_filter.dart';
import 'package:newheadline/widgets/site_filter.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  await DotEnv.load(fileName: ".env");
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: Auth()),
      ChangeNotifierProvider.value(value: CategoryProvider()),
      ChangeNotifierProvider.value(value: ArticleProvider()),
      ChangeNotifierProvider.value(value: SubscriptionProvider()),
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
          onGenerateRoute: (RouteSettings settings) {
            var routes = <String, WidgetBuilder>{
              "RelatedScreen": (ctx) => RelatedScreen(settings.arguments),
            };
            WidgetBuilder builder = routes[settings.name];
            return MaterialPageRoute(builder: (ctx) => builder(ctx));
          },
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
            DisplayScreen.routeName: (ctx) => DisplayScreen(),
            ResetPasswordScreen.routeName: (ctx) => ResetPasswordScreen(),
            DateFilter.routeName: (ctx) => DateFilter(),
            SiteFilter.routeName: (ctx) => SiteFilter(),
            CategoryFilter.routeName: (ctx) => CategoryFilter(),
            ForgetScreen.routeName: (ctx) => ForgetScreen(),
          }),
    );
  }
}
