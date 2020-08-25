import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic user;
  var test;
  // Future<void> getData() async {
  //   var response = await get(
  //     'http://192.168.29.72:7000/api/test/',
  //     headers: {
  //       "Authorization":
  //           "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1ZjNmNmY4YTYyNjQ1MzI0ZjAyYzVlYWEiLCJpYXQiOjE1OTgxOTYzNjcyODEsImV4cCI6MTU5ODE5NjQ1MzY4MX0._HoXbosMj4GoiWECS_cTuG0696q9fGh4ALnkmGWE9tI"
  //     },
  //   );
  //   setState(() {
  //     this.user = json.decode(response.body);
  //   });
  // }

  // Future<void> getData1() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   var ans = pref.getString("token");
  //   setState(() {
  //     this.test = ans;
  //   });
  // }

  Future<void> removeDataLocal() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 24, 24, 1),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Center(
                child: Text(
                  "HOME",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                onPressed: () async {
                  await removeDataLocal();
                  Navigator.popAndPushNamed(context, '/authenticate');
                },
                child: Text(
                  "LOGOUT",
                  style: TextStyle(
                    color: Colors.white,
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
