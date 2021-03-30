import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ngabflutter/backend/auth.dart';
import 'package:ngabflutter/pages/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeKu extends StatefulWidget {
  final String uid;

  HomeKu({Key key, @required this.uid}) : super(key: key);

  @override
  _HomeKuState createState() => _HomeKuState(uid);
}

class _HomeKuState extends State<HomeKu> {
  final String uid;
  _HomeKuState(this.uid);
  final AuthService _auth = AuthService();
  var taskcollections = FirebaseFirestore.instance.collection('tasks');
  String task;

  void showdialog(bool isUpdate, DocumentSnapshot ds) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: isUpdate ? Text("Update Todo") : Text("Add Todo"),
            content: Form(
              key: formkey,
              autovalidate: true,
              child: TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Task",
                ),
                validator: (_val) {
                  if (_val.isEmpty) {
                    return "Can't Be Empty";
                  } else {
                    return null;
                  }
                },
                onChanged: (_val) {
                  task = _val;
                },
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                color: Colors.purple,
                onPressed: () {
                  if (formkey.currentState.validate()) {
                    formkey.currentState.save();
                    if (isUpdate) {
                      taskcollections
                          .document(uid)
                          .collection('task')
                          .document(ds.documentID)
                          .updateData({
                        'task': task,
                        'time': DateTime.now(),
                      });
                    } else {
                      //  insert
                      taskcollections.document(uid).collection('task').add({
                        'task': task,
                        'time': DateTime.now(),
                      });
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                    fontFamily: "tepeno",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        });
  }

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
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () async {
                  await _auth.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Signup()));
                },
              )
            ],
          ),
        ),
        body: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (_, home) {
              return Container(
                margin: EdgeInsets.all(10),
                height: 150,
                color: Colors.grey[200],
              );
            }),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPage(),
                  ));
            }));
  }
}
