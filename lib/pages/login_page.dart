import 'package:flutter/material.dart';
import 'package:ngabflutter/pages/home.dart';
import 'package:ngabflutter/backend/auth.dart';
import 'package:ngabflutter/pages/homepage.dart';
import 'package:ngabflutter/pages/func.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

// class Func {
//   final String email;
//   final String password;

//   Func({
//     this.email,
//     this.password,
//   });
// }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  TextEditingController _emailConn = TextEditingController();
  TextEditingController _passConn = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.blueGrey,
        //   elevation: 10,
        //   iconTheme: IconThemeData(color: Colors.white),
        //   title: Text(
        //     'Sign-In',
        //     style: TextStyle(color: Colors.white),
        //   ),
        //   centerTitle: true,
        // ),
        body: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.blueGrey, Colors.lightBlueAccent]),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(93),
                        child: Text(
                          "DouDes",
                          style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                              fontSize: 40),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: TextFormField(
                          controller: _emailConn,
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Kosong Goblok";
                            }
                            if (val.length < 2) {
                              return "Kurang Goblok";
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            labelText: "Email",
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: TextFormField(
                          obscureText: true,
                          controller: _passConn,
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Kosong Goblok";
                            }
                            if (val.length < 6) {
                              return "Kurang Goblok";
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            labelText: "Password",
                          ),
                        ),
                      ),
                      // tempikan
                      Container(
                        height: 70,
                        width: 150,
                        padding: EdgeInsets.all(10),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.lightBlue,
                          child: Text("Login"),
                          onPressed: () async {
                            signInUser();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 125,
                      ),
                      Text("New In DouDes??? Create Account")
                    ],
                  ),
                ))));
  }

  void signInUser() async {
    dynamic authResult = await _auth.newLogin(_emailConn.text, _passConn.text);
    if (authResult == null) {
      print('Failed : ${authResult.code}');
      print(authResult.message);
    } else {
      _emailConn.clear();
      _passConn.clear();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeKu()));
    }
  }
}
