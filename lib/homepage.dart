import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  String email;
  String password;

  Home({Key key, @required this.email, @required this.password})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState(email, password);
}

class _HomeState extends State<Home> {
  String email;
  String password;

  _HomeState(this.email, this.password);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Home")),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(50),
            child: Text(
              "Welcome",
              style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  fontSize: 40),
            ),
          ),
          Container(
            child: Center(
              child: Text(
                email,
                style: TextStyle(
                    color: Colors.red,
                    fontStyle: FontStyle.italic,
                    fontSize: 20.0),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(50),
            child: Text(
              "Your Password Is",
              style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  fontSize: 30),
            ),
          ),
          Container(
            child: Center(
              child: Text(
                password,
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
