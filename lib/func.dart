import 'dart:async';
import 'package:ngabflutter/homepage.dart';
import 'package:ngabflutter/signup.dart';
import 'package:flutter/material.dart';
import 'package:ngabflutter/login_page.dart';

class MyTerminal extends StatefulWidget {
  @override
  _MyTerminalState createState() => _MyTerminalState();
}

void goToLogin(BuildContext context) {
  Navigator.pushReplacement(
      context,
      new MaterialPageRoute(
          builder: (BuildContext context) => new LoginPage()));
}

void goToSignup(BuildContext context) {
  Navigator.pushReplacement(context,
      new MaterialPageRoute(builder: (BuildContext context) => new Signup()));
}

// StreamController<Func> events = StreamController<Func>();

class _MyTerminalState extends State<MyTerminal> {
  // List<Func> terminalNodes = [];

  // @override
  // initState() {
  //   events.stream.listen((data) {
  //     terminalNodes.add(data);
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        //   child: Container(
        //     child: Column(
        //       children: terminalNodes.map((node){
        //         return Card(
        //           child: row,
        //         )
        //       },
        //     ),
        //   ),
        );
  }
}
