import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newheadline/models/user.dart';

class Auth with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(User user) {
    return user != null ? user : null;
  }

  Stream<User> get user {
    return _auth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user != null ? user : null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      // notifyListeners();
      // var token = await user.getIdToken();
      // print(token);
      return user != null ? user : null;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      notifyListeners();

      return user != null ? user : null;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      await _auth.signOut();

      // notifyListeners();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  String get uid {
    return _auth.currentUser != null ? _auth.currentUser.uid : null;
  }

  User get currentUser {
    return _auth.currentUser;
  }

  Future<String> getToken() async {
    return await _auth.currentUser.getIdToken();
  }

  // String get token {
  //   String t = "";
  //   getToken().then((String result) {
  //     print("hello");
  //     t = result;
  //   });
  //   return t;
  // }
}
