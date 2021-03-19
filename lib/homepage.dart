import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Home")),
      ),
      body: ListView(
        children: [
          Container(
            child: Center(
              child: Text(
                "Bapak",
                style: TextStyle(
                    color: Colors.red,
                    fontStyle: FontStyle.italic,
                    fontSize: 20.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
