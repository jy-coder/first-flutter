import 'package:flutter/material.dart';
import 'package:newheadline/models/user.dart';
import 'package:newheadline/provider/provider.dart';
import 'package:newheadline/screens/authenticate/authenticate.dart';
import 'package:newheadline/screens/pages/article_screen.dart';
import 'package:newheadline/screens/pages/category_article_screen.dart';
import 'package:newheadline/screens/pages/category_overview_screen.dart';
import 'package:newheadline/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newheadline/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CategoryProvider>(
          create: (_) => CategoryProvider()),
      ChangeNotifierProvider<CategoryArticleProvider>(
          create: (_) => CategoryArticleProvider()),
    ],
    child: MaterialApp(home: MyApp()),
  ));
}

// ChangeNotifierProvider(
//     create: (ctx) => CategoryProvider(),
//     child: MaterialApp(home: MyApp()),
//   ),
// );

// runApp(
//   ChangeNotifierProvider<Auth>(
//     create: (_) => Auth(),
//     child: MaterialApp(home: MyApp()),
//   ),
// );

//3
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<CategoryProvider, CategoryArticleProvider>(
      builder: (_, categoryProvider, categoryArticleProvider, __) {
        return MaterialApp(
            title: 'Firebase Auth Demo',
            theme: ThemeData(
                // primarySwatch: Colors.brown,
                accentColor: Colors.amber,
                fontFamily: 'Quicksand',
                textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                appBarTheme: AppBarTheme(
                  color: Colors.brown[400],
                  textTheme: ThemeData.light().textTheme.copyWith(
                        headline6: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                ),
                buttonTheme: ButtonThemeData(
                  buttonColor: Colors.white,
                  textTheme: ButtonTextTheme.primary,
                )),
            home: Wrapper(),
            routes: {
              CategoryArticleScreen.routeName: (ctx) => CategoryArticleScreen(),
              CategoryScreen.routeName: (ctx) => CategoryScreen(),
              ArticleScreen.routeName: (ctx) => ArticleScreen()
            }
            // home: _RegisterEmailSection(),x
            );
      },
    );
  }
}

// return Consumer<Auth>(
//   builder: (_, auth, __) {
//     if (auth.loggedIn) return Wrapper();
//     else return Authenticate();
//   },
// );
//   }
// }

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
