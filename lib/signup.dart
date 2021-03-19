import 'package:flutter/material.dart';
import 'package:ngabflutter/func.dart';
import 'package:ngabflutter/login_page.dart';
import 'package:ngabflutter/login_page.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // String emailInput;
  // String nameInput;
  // String passwordInput;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SignUp"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    // onChanged: (val) {
                    //   emailInput = val;
                    // },
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
                  child: TextField(
                    // onChanged: (val) {
                    //   nameInput = val;
                    // },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: "Name",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    // onChanged: (val) {
                    //   passwordInput = val;
                    // },
                    obscureText: true,
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
                  color: Colors.red,
                  child: Text("Login"),
                  onPressed: () {
                    goToLogin(context);
                  },
                ),
              ),
              // Navigator.of(context)
              //       .push(MaterialPageRoute(builder: (v) => Signup()));
            ],
          ),
        ));
  }
}
