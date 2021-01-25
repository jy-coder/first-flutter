import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newheadline/models/user.dart';

class Auth with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;
  // create user obj based on firebase user
  // AppUser _userFromFirebaseUser(User user) {
  //   return user != null ? AppUser(uid: user.uid) : null;
  // }

  // Future<String> getToken() async {
  //   User user = _auth.currentUser;
  //   String token = await user.getIdToken();
  //   return token;
  // }

  // Stream<AppUser> get user {
  //   return _auth
  //       .authStateChanges()
  //       // .map((User user) => _userFromFirebaseUser(user));
  //       .map(_userFromFirebaseUser);
  // }

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
      _loggedIn = true;
      notifyListeners();
      // var token = await user.getIdToken();
      // print(token);
      return user;
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
      _loggedIn = false;
      notifyListeners();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<User> getCurrentUser() async {
    return _auth.currentUser;
  }
}
