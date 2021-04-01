import 'package:flutter/material.dart';
import 'package:ngabflutter/pages/home.dart';
import 'package:ngabflutter/backend/auth.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;

  final AuthService _auth = AuthService();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

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
                        padding: EdgeInsets.all(93),
                        child: Text(
                          "Ressipe",
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
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Kosong Goblok"),
                            EmailValidator(
                                errorText: "Seng Genah Iki Form Email"),
                          ]),
                          onChanged: (val) {
                            email = val;
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
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Kosong Goblok"),
                            MinLengthValidator(6, errorText: "Minimal 6 Char"),
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
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      _auth.signin(email, password, context).then((value) {
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
