import 'dart:async';
import 'package:ngabflutter/pages/homepage.dart';
import 'package:ngabflutter/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:ngabflutter/pages/login_page.dart';
import 'package:http/http.dart' as http;

class MyTerminal extends StatefulWidget {
  @override
  _MyTerminalState createState() => _MyTerminalState();
}

Widget goToLogin(context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (c) => LoginPage()));
}

Widget goToHome(context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (c) => HomeKu()));
}

Widget getCard(index) {
  var fullName = index['first_name'] + "" + index['last_name'];
  var email = index['email'];
  var avatar = index['avatar'];

  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
            title: Row(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(avatar.toString()))),
            ),
            SizedBox(width: 20),
            Column(
              children: <Widget>[
                Center(
                  child: Text(fullName.toString(),
                      style: TextStyle(fontSize: 15, color: Colors.black)),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(email.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic)),
                ),
              ],
            ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: <Widget>[Icon(Icons.person_add)],
            // ),
          ],
        )),
      ),
    ),
  );
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
