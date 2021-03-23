import 'package:flutter/material.dart';
import 'package:ngabflutter/homepage.dart';
import 'package:ngabflutter/func.dart';
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
  final _auth = FirebaseAuth.instance;

  bool showProgress = false;

  String emailInput;
  String passwordInput;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("DouDes-Login")),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(50),
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
                child: TextField(
                  onChanged: (value) {
                    emailInput = value;
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
                child: TextField(
                  onChanged: (value) {
                    passwordInput = value;
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
                      setState(() {
                        showProgress = true;
                      });
                      try {
                        final newuser =
                            await _auth.createUserWithEmailAndPassword(
                                email: emailInput, password: passwordInput);
                        if (newuser != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                          setState(() {
                            showProgress = false;
                          });
                        }
                      } catch (e) {}
                      //   Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //       builder: (context) => Home(
                      //             email: emailInput,
                      //             password: passwordInput,
                      //           )));
                    }),
              ),
              SizedBox(
                height: 125,
              ),
              Text("New In DouDes??? Create Account")
            ],
          ),
        ));
  }
}
