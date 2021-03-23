import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeKu extends StatefulWidget {
  @override
  _HomeKuState createState() => _HomeKuState();
}

class _HomeKuState extends State<HomeKu> {
  final _auth = FirebaseAuth.instance;
  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
