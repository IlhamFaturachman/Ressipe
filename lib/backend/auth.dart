import 'package:firebase_auth/firebase_auth.dart';
import 'package:ngabflutter/pages/signup.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future registerEmailPass(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future newLogin(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user not found') {
        return "No User Found";
      } else if (e.code == 'wrong password') {
        return "Wrong Password";
      }
    }
  }
}

// class EmailValidator {
//   static String validate(String val) {
//     if (val.isEmpty) {
//       return "Kosong Goblok";
//     }
//     if (val.length > 50) {
//       return "Kakehan Asu";
//     }
//     if (val.isEmpty) {
//       return "Kosong Goblok";
//     }
//     return null;
//   }
// }

// class PassValidator {
//   static String validate(String val) {
//     if (val.isEmpty) {
//       return "Kosong Goblok";
//     }
//     if (val.length < 2) {
//       return "Kurang Goblok";
//     }
//     if (val.length > 8) {
//       return "Kakehan Blok";
//     }
//     return null;
//   }
// }
