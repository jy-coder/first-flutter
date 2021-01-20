import 'package:flutter/material.dart';
import 'package:newheadline/models/user.dart';
import 'package:newheadline/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newheadline/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

//3
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser>.value(
        value: AuthService().user,
        child: MaterialApp(
          title: 'Firebase Auth Demo',
          home: Wrapper(),
        )
        // home: _RegisterEmailSection(),x
        );
  }
}
