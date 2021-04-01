import 'package:flutter/material.dart';
import 'package:ngabflutter/backend/auth.dart';
import 'package:ngabflutter/pages/login_page.dart';
import 'package:ngabflutter/pages/home.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String email;
  String password;

  final formkey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.blueGrey, Colors.lightBlueAccent]),
                ),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(85),
                        child: Text(
                          "DouDes",
                          style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                              fontSize: 40),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 70.0),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: TextFormField(
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Kosong Goblok";
                              }
                              if (val.length < 2) {
                                return "Kurang Goblok";
                              } else
                                return null;
                            },
                            onChanged: (val) {
                              email = val;
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
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "This Field Is Required."),
                              MinLengthValidator(6,
                                  errorText: "Minimum 6 Characters Required.")
                            ]),
                            onChanged: (val) {
                              password = val;
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
                              registerEmailPass();
                            }),
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
                    ],
                  ),
                ))));
  }

  void registerEmailPass() async {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      _auth.signUp(email.trim(), password, context).then((value) {
        if (value != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeKu(uid: value.uid),
              ));
        }
      });
    }
  }
}
