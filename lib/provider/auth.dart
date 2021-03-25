import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Auth with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _token;

  FirebaseUser _userFromFirebaseUser(FirebaseUser user) {
    return user;
  }

  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //   Future signInWithEmailAndPassword(String email, String password) async {
  //   try {
  //     UserCredential result = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     // User user = result.user;

  //     // return user != null ? user : null;
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //   } on PlatformException catch (e) {
  //     print(e);
  //   } on Exception catch (e) {
  //     print(e);
  //   }
  // }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      await _auth.signOut();
      notifyListeners();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  String get token {
    return _token;
  }

  Future get currentUser async {
    FirebaseUser user = await _auth.currentUser();
    IdTokenResult result = await user.getIdToken();
    if (result != null) {
      _token = result.token.toString();
    } else {
      return null;
    }
    // print(result.token);
  }
}
