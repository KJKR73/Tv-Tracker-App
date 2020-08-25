import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:tv_tracker_flutter/services/authentication/auth.dart';
import 'package:tv_tracker_flutter/shared/constants.dart';

class Register extends StatefulWidget {
  Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = new AuthService();
  String username;
  String email;
  String password;
  String err;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(32, 26, 48, 1),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: ClipPath(
                  clipper: TopClipper(),
                  child: Container(
                    color: Color.fromRGBO(13, 245, 227, 1),
                    child: Align(
                      alignment: Alignment.center,
                      child: FittedBox(
                        child: Text(
                          "TV-Tracker",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            fontFamily: "PM",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 20,
                    top: 20,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () => {widget.toggleView()},
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          child: Text(
                            "Register",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                this.username = value;
                              });
                            },
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            validator: (val) =>
                                val.isEmpty ? "Enter a valid Username" : null,
                            decoration: formDecoration().copyWith(
                              hintText: "Enter Username",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                this.email = value;
                              });
                            },
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            validator: (val) =>
                                val.isEmpty ? "Enter a Email" : null,
                            decoration: formDecoration().copyWith(
                              hintText: "Enter Email",
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            bottom: 40,
                          ),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                this.password = value;
                              });
                            },
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            validator: (val) =>
                                val.isEmpty ? "Enter a valid password" : null,
                            decoration: formDecoration().copyWith(
                              hintText: "Enter Password",
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          err == null ? "" : this.err,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          ),
                        ),
                        ButtonTheme(
                          height: 60.0,
                          minWidth: 220.0,
                          buttonColor: Color.fromRGBO(13, 245, 227, 1),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            textColor: Colors.black,
                            color: Color.fromRGBO(13, 245, 227, 1),
                            child: Text(
                              "REGISTER",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                Map body = {
                                  "username": this.username,
                                  "email": this.email,
                                  "password": this.password,
                                };

                                var response = await _auth.registerUser(body);

                                // check if the user was saved
                                try {
                                  if (response.statusCode == 200) {
                                    Fluttertoast.showToast(
                                      msg: "Success",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor:
                                          Color.fromRGBO(32, 26, 48, 1),
                                      textColor:
                                          Color.fromRGBO(13, 245, 227, 1),
                                      fontSize: 16.0,
                                    );
                                    widget.toggleView();
                                  } else {
                                    setState(() {
                                      this.err = response.body.toString();
                                    });
                                  }
                                } catch (ex) {
                                  print(ex);
                                }
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
