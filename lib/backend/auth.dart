import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthService {
  User user;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => auth.authStateChanges().map(
        (User user) => user?.uid,
      );

  // GET UID
  String getCurrentUID() {
    return auth.currentUser.uid;
  }

  // GET CURRENT USER
  Future getCurrentUser() async {
    return auth.currentUser;
  }

  showErrDialog(BuildContext context, String err) {
    FocusScope.of(context).requestFocus(new FocusNode());
    return showDialog(
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(err),
        actions: <Widget>[
          OutlineButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"),
          ),
        ],
      ),
      context: context,
    );
  }

  //SignUP

  Future<User> signUp(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: email);
      User user = result.user;
      return Future.value(user);
      // return Future.value(true);
    } catch (error) {
      switch (error.code) {
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          showErrDialog(context, "Email Already Exists");
          break;
        case 'ERROR_INVALID_EMAIL':
          showErrDialog(context, "Invalid Email Address");
          break;
        case 'ERROR_WEAK_PASSWORD':
          showErrDialog(context, "Please Choose a stronger password");
          break;
      }
      return Future.value(null);
    }
  }

  //SignIn

  Future<User> signin(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result =
          await auth.signInWithEmailAndPassword(email: email, password: email);
      user = result.user;
      // return Future.value(true);
      return Future.value(user);
    } catch (e) {
      // simply passing error code as a message
      print(e.code);
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          showErrDialog(context, e.code);
          break;
        case 'ERROR_WRONG_PASSWORD':
          showErrDialog(context, e.code);
          break;
        case 'ERROR_USER_NOT_FOUND':
          showErrDialog(context, e.code);
          break;
        case 'ERROR_USER_DISABLED':
          showErrDialog(context, e.code);
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          showErrDialog(context, e.code);
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          showErrDialog(context, e.code);
          break;
      }
      return Future.value(null);
    }
  }

  //SignOut

  Future<void> signOut() async {
    await auth.signOut();
  }
}
