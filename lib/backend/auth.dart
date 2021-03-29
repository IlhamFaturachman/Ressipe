import 'package:firebase_auth/firebase_auth.dart';
import 'package:ngabflutter/pages/signup.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get authState => FirebaseAuth.instance.idTokenChanges();

  var errorMessage;

  //SignUP

  Future registerEmailPass(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SignIn

  Future newLogin(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  //SignOut

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
