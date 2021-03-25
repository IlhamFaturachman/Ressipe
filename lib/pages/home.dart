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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        elevation: 10,
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.notifications),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Kawand'),
              accountEmail: Text('Kawand@gmail.com'),
              decoration: BoxDecoration(color: Colors.blueAccent),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Drawer layout Item 1'),
                onTap: () {
                  //bapak
                },
              ),
            ),
            Divider(
              height: 10.0,
            ),
            ListTile(
              leading: Icon(Icons.accessibility),
              title: Text('Drawer layout Item 2'),
              onTap: () {
                //Bapak
              },
            ),
            Divider(
              height: 10.0,
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text('Drawer layout Item 3'),
              onTap: () {
                //bapak
              },
            )
          ],
        ),
      ),
    );
  }
}
