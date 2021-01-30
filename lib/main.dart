import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newheadline/models/user.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/category.dart';
import 'package:newheadline/provider/subscription.dart';
import 'package:newheadline/screens/authenticate/authenticate.dart';
import 'package:newheadline/screens/pages/article_screen.dart';
import 'package:newheadline/screens/pages/category_article_screen.dart';
import 'package:newheadline/screens/pages/category_screen.dart';
import 'package:newheadline/screens/pages/home_screen.dart';
import 'package:newheadline/screens/pages/setting_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newheadline/utils/auth.dart';
import 'package:newheadline/screens/authenticate/login_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: Auth()),
      ChangeNotifierProvider.value(value: CategoryProvider()),
      ChangeNotifierProvider.value(value: ArticleProvider()),
      ChangeNotifierProvider.value(value: SubscriptionProvider())
    ],
    child: MaterialApp(home: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (_, auth, __) {
        return MaterialApp(
            title: 'NewsHeadline',
            theme: new ThemeData(
                appBarTheme: AppBarTheme(
                  color: Colors.white,
                ),
                primaryTextTheme:
                    TextTheme(headline6: TextStyle(color: Colors.black)),
                primaryIconTheme: IconThemeData(
                  color: Colors.black,
                ),
                buttonTheme: ButtonThemeData(
                  buttonColor: Colors.black87, //  <-- dark color
                  textTheme: ButtonTextTheme
                      .primary, //  <-- this auto selects the right color
                )),
            home: auth.uid != null ? HomeScreen() : CategoryScreen(),
            routes: {
              CategoryArticleScreen.routeName: (ctx) => CategoryArticleScreen(),
              CategoryScreen.routeName: (ctx) => CategoryScreen(),
              ArticleScreen.routeName: (ctx) => ArticleScreen(),
              HomeScreen.routeName: (ctx) => HomeScreen(),
              SettingScreen.routeName: (ctx) => SettingScreen(),
              Authenticate.routeName: (ctx) => Authenticate()
            }
            // home: _RegisterEmailSection(),x
            );
      },
    );
  }
}

//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Firebase Auth Demo',
//         theme: ThemeData(
//             // primarySwatch: Colors.brown,
//             accentColor: Colors.amber,
//             fontFamily: 'Quicksand',
//             textTheme: ThemeData.light().textTheme.copyWith(
//                   headline6: TextStyle(
//                     fontFamily: 'OpenSans',
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//             appBarTheme: AppBarTheme(
//               color: Colors.brown[400],
//               textTheme: ThemeData.light().textTheme.copyWith(
//                     headline6: TextStyle(
//                       fontFamily: 'OpenSans',
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//             ),
//             buttonTheme: ButtonThemeData(
//               buttonColor: Colors.white,
//               textTheme: ButtonTextTheme.primary,
//             )),
//         home: Wrapper(),
//         routes: {
//           CategoryArticleScreen.routeName: (ctx) => CategoryArticleScreen()
//         }
//         // home: _RegisterEmailSection(),x
//         );
//   }
// }
