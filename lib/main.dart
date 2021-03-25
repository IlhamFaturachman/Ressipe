import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ngabflutter/pages/signup.dart';
import 'package:ngabflutter/pages/signup.dart';
import 'package:ngabflutter/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primarySwatch: Colors.blueGrey),
      home: Signup(),
    );
  }
}
