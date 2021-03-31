import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ngabflutter/backend/auth.dart';
import 'package:ngabflutter/pages/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ngabflutter/pages/AddPage.dart';

class HomeKu extends StatefulWidget {
  final String uid;

  HomeKu({Key key, @required this.uid}) : super(key: key);

  @override
  _HomeKuState createState() => _HomeKuState(uid);
}

class _HomeKuState extends State<HomeKu> {
  final String uid;
  _HomeKuState(this.uid);
  TextEditingController _name = TextEditingController();
  TextEditingController _bahan = TextEditingController();

  final AuthService _auth = AuthService();

  var recipecollections = FirebaseFirestore.instance.collection('recipe');

  List allRecipes = [];

  Future<void> getRecipes() async {
    await recipecollections.get().then((result) => {
          result.docs.forEach((element) {
            print(element.data()['name']);
            allRecipes.add(element.data());
          })
        });
  }

  @override
  initState() async {
    await getRecipes();
    setState(() {});
    super.initState();
  }

  String name;
  String ingredient;

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
                child: Column(children: [
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Name",
                    ),
                    validator: (_val) {
                      if (_val.isEmpty) {
                        return "Can't Be Empty";
                      } else {
                        return null;
                      }
                    },
                    controller: _name,
                  ),
                  TextFormField(
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
                    controller: _bahan,
                  ),
                ])),
            actions: <Widget>[
              RaisedButton(
                color: Colors.purple,
                onPressed: () async {
                  if (formkey.currentState.validate()) {
                    formkey.currentState.save();
                    User user = await FirebaseAuth.instance.currentUser;
                    await recipecollections.add({
                      'name': _name.text,
                      'bahan': _bahan.text,
                      'image': "",
                      'author': user.email
                    });

                    // if (isUpdate) {
                    //   recipecollections
                    //       .collection('recipe').doc(uid)
                    //       .updateData({
                    //     'name': name,
                    //     'ingredient': ingredient,
                    //   });
                    // } else {
                    //   //  insert
                    //   recipecollections.document(uid).collection('recipe').add({
                    //     'name': name,
                    //     'ingredient': ingredient,
                    //   });
                    // }
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
    var recipesdata = recipecollections.get();
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
        body:

            // Column(
            //   children: [
            //     for (var i in allRecipes)
            //       Container(
            //         color: Colors.yellow,
            //         child: Text(i['name']),
            //       )
            //   ],
            // ),

            GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (_, home) {
                  if (home < allRecipes.length) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      height: 150,
                      color: Colors.grey[200],
                      child: Column(children: [
                        Text("Nama : " + allRecipes[home]['name'].toString()),
                        Text("Bahan : " + allRecipes[home]['bahan'].toString()),
                      ]),
                    );
                  }
                  return Text("");
                }),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => showdialog(false, null),
        ));
  }
}
