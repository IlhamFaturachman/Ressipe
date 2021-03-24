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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.deepPurple),
          title: Text(
            'Sign-In',
            style: TextStyle(color: Colors.deepPurple),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
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
                child: TextFormField(
                  controller: _emailConn,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Kosong Goblok";
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
                  // onPressed: () async {
                  //   setState(() {
                  //     showProgress = true;
                  //   });
                  //   try {
                  //     final newUser = await _auth.signInWithEmailAndPassword(
                  //         email: emailInput, password: passwordInput);
                  //     print(newUser.toString());
                  //     if (newUser != null) {
                  //       Navigator.pushReplacement(context,
                  //           MaterialPageRoute(builder: (context) => HomeKu()));
                  //       setState(() {
                  //         showProgress = false;
                  //       });
                  //     }
                  //   } catch (e) {}
                  // },
                  //   Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //       builder: (context) => Home(
                  //             email: emailInput,
                  //             password: passwordInput,
                  //           )));
                ),
              ),
              SizedBox(
                height: 125,
              ),
              Text("New In DouDes??? Create Account")
            ],
          ),
        )));
  }

  void signInUser() async {
    dynamic authResult = await _auth.newLogin(_emailConn.text, _passConn.text);
    if (authResult == null) {
      print("Gabisa Tolol");
    } else {
      _emailConn.clear();
      _passConn.clear();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeKu()));
    }
  }
}
