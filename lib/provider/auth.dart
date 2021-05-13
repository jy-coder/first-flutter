import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

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
      return user != null ? user : null;
    } catch (error) {
      return null;
    }
  }

  Future resetPassword(String password) async {
    String currentEmail = _auth.currentUser.email;

    AuthCredential credential =
        EmailAuthProvider.credential(email: currentEmail, password: password);
    try {
      await _auth.currentUser.reauthenticateWithCredential(credential);
      await _auth.sendPasswordResetEmail(email: currentEmail);
    } catch (err) {
      print(err);
      return err;
    }
  }

  Future resetForgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (err) {
      print(err);
      return err;
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

  User get currentUser {
    return _auth.currentUser;
  }
}
