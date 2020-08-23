import 'package:flutter/material.dart';
import 'package:tv_tracker_flutter/screens/home/home.dart';
import 'package:tv_tracker_flutter/screens/wrapper.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => Home(),
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
