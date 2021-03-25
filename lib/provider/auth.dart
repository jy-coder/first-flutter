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
    String errorMessage;
    FirebaseUser user;
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
    } catch (error) {
      print("here");
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }

    return user;
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

  Future<FirebaseUser> get currentUser async {
    FirebaseUser user = await _auth.currentUser();
    return user;
    // IdTokenResult result = await user.getIdToken();
    // if (result != null) {
    //   _token = result.token.toString();
    // } else {
    //   return null;
    // }
    // print(result.token);
  }
}
