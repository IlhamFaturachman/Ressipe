import 'package:flutter/material.dart';
import 'package:ngabflutter/backend/auth.dart';
import 'package:ngabflutter/pages/func.dart';
import 'package:ngabflutter/pages/login_page.dart';
import 'package:ngabflutter/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ngabflutter/pages/login_page.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

  TextEditingController _emailConn = TextEditingController();
  TextEditingController _passConn = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.deepPurple),
          title: Text(
            'Sign-Up',
            style: TextStyle(color: Colors.deepPurple),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _emailConn,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Kosong Goblok";
                      } else
                        return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: "Email",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    obscureText: true,
                    controller: _passConn,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Kosong Goblok";
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
              ),
              Container(
                height: 70,
                width: 150,
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.deepPurple,
                    child: Text("Sign-Up"),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        registerEmailPass();
                      }
                    }
                    // onPressed: () async {
                    //   setState(() {
                    //     showProgress = true;
                    //   });
                    //   try {
                    //     final newuser =
                    //         await _auth.createUserWithEmailAndPassword(
                    //             email: emailInput, password: passwordInput);
                    //     if (newuser != null) {
                    //       Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(builder: (context) => LoginPage()),
                    //       );
                    //       setState(() {
                    //         showProgress = false;
                    //       });
                    //     }
                    //   } catch (e) {}
                    // },
                    ),
              ),
              Text("Or"),
              Container(
                  height: 70,
                  width: 150,
                  padding: EdgeInsets.all(10),
                  child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.lightBlue,
                      child: Text("Login"),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      })),
              // Navigator.of(context)
              //       .push(MaterialPageRoute(builder: (v) => Signup()));
            ],
          ),
        )));
  }

  void registerEmailPass() async {
    dynamic result =
        await _auth.registerEmailPass(_emailConn.text, _passConn.text);
    if (result == null) {
      print("email Isn't Valid");
    } else {
      print(result.toString());
      _emailConn.clear();
      _passConn.clear();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }
}
