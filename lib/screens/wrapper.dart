import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_tracker_flutter/screens/authenticate/authenticate.dart';
import 'package:tv_tracker_flutter/screens/home/home.dart';

// This handles what screen to show whether to show the authenticate
// screen or the Home screen
class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Future<bool> autoLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey("token")) {
      if (pref.getString('token').isNotEmpty) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: autoLogin(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == true) {
          return Home();
        } else {
          return Authenticate();
        }
      },
    );
  }
}
