import 'package:flutter/material.dart';
import 'package:tv_tracker_flutter/screens/authenticate/authenticate.dart';
import 'package:tv_tracker_flutter/screens/authenticate/login.dart';
import 'package:tv_tracker_flutter/screens/authenticate/register.dart';
import 'package:tv_tracker_flutter/screens/home/home.dart';

// This handles what screen to show whether to show the authenticate
// screen or the Home screen
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Authenticate();
  }
}
