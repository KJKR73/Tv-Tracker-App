import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_tracker_flutter/services/authentication/auth.dart';
import 'package:tv_tracker_flutter/shared/constants.dart';

class Login extends StatefulWidget {
  Function toggleView;
  Login({this.toggleView});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username;
  String password;
  String email;
  Map data;
  var responseServer;
  String err;

  Future<void> saveDataLocal(data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("token", data["token"]);
    pref.setString("_id", data["user_id"]);
  }

  AuthService auth = new AuthService();

  final _formkey = GlobalKey<FormState>();
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
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () => {widget.toggleView()},
                          child: Text(
                            "Register",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[700],
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
                                this.email = value;
                              });
                            },
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            validator: (val) =>
                                val.isEmpty ? "Enter a Email" : null,
                            decoration: formDecoration()
                                .copyWith(hintText: "Enter Email"),
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
                            decoration: formDecoration()
                                .copyWith(hintText: "Enter Password"),
                          ),
                        ),
                        Text(
                          err == null ? "" : err,
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
                              "LOGIN",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                Map requestBody = {
                                  "email": this.email,
                                  "password": this.password,
                                };

                                // Make a post request here
                                var responseServer =
                                    await auth.postLogin(requestBody);

                                try {
                                  // if login details valid check for success msg
                                  var success =
                                      json.decode(responseServer)["success"];

                                  if (success) {
                                    Navigator.popAndPushNamed(context, '/home');
                                  }
                                } catch (ex) {
                                  setState(() {
                                    this.err = "Invalid username/password";
                                  });
                                }
                                // Save the user data in the shared prefs fo the first time
                                saveDataLocal(json.decode(responseServer));
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
