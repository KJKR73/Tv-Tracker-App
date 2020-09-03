import 'package:flutter/material.dart';
import 'package:tv_tracker_flutter/screens/add/add_info.dart';
import 'package:tv_tracker_flutter/screens/add/add_new.dart';
import 'package:tv_tracker_flutter/screens/authenticate/authenticate.dart';
import 'package:tv_tracker_flutter/screens/home/home.dart';
import 'package:tv_tracker_flutter/screens/watching/watching_ind.dart';
import 'package:tv_tracker_flutter/screens/wrapper.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => Home(),
        '/authenticate': (context) => Authenticate(),
        '/addnew': (context) => AddNew(),
        '/add_info': (context) => AddInfo(),
        '/watch_info': (context) => WatchInd(),
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
