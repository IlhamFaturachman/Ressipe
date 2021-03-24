import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ngabflutter/pages/func.dart';

class Home extends StatefulWidget {
  String email;
  String password;

  Home({Key key, @required this.email, @required this.password})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState(email, password);
}

class _HomeState extends State<Home> {
  List users = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    var url = Uri.parse("https://reqres.in/api/users");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var items = json.decode(response.body)['data'];
      print(items);
      setState(() {
        users = items;
      });
    } else {
      setState(() {
        users = [];
      });
    }
  }

  String email;
  String password;

  _HomeState(this.email, this.password);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                goToLogin(context);
              })
        ],
        title: Center(child: Text("Home")),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    List items = ["1", "2"];
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return getCard(users[index]);
        });
  }
}
