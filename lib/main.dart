import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:tv_tracker_flutter/screens/add/add_info.dart';
import 'package:tv_tracker_flutter/screens/add/add_new.dart';
import 'package:tv_tracker_flutter/screens/authenticate/authenticate.dart';
import 'package:tv_tracker_flutter/screens/completed/completed_ind.dart';
import 'package:tv_tracker_flutter/screens/dropped/dropped_ind.dart';
import 'package:tv_tracker_flutter/screens/home/home.dart';
import 'package:tv_tracker_flutter/screens/watching/watching_ind.dart';
import 'package:tv_tracker_flutter/screens/wrapper.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color.fromRGBO(9, 12, 37, 1));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => Home(),
        '/authenticate': (context) => Authenticate(),
        '/addnew': (context) => AddNew(),
        '/add_info': (context) => AddInfo(),
        '/watch_info': (context) => WatchInd(),
        '/completed_info': (context) => CompletedInd(),
        '/dropped_info': (context) => DroppedInd(),
      },
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Wrapper(),
          ),
        ),
      ),
    );
  }
}
