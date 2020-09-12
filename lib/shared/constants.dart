import 'package:flutter/material.dart';

InputDecoration formDecoration() {
  return InputDecoration(
    hintStyle: TextStyle(
      color: Colors.white,
      fontSize: 15,
    ),
    fillColor: Color.fromRGBO(56, 48, 77, 1),
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
      borderSide: BorderSide(
        color: Color.fromRGBO(13, 245, 227, 1),
        width: 3,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
      borderSide: BorderSide(
        color: Color.fromRGBO(56, 48, 100, 1),
        width: 3,
      ),
    ),
  );
}

// Define the colors here

Color primaryColor = Color.fromRGBO(9, 12, 28, 1);
Color secondaryColor = Color.fromRGBO(13, 245, 227, 1);

BoxDecoration topDecor() {
  return BoxDecoration(
    color: Colors.black,
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.pink,
        Colors.orange,
      ],
    ),
    borderRadius: BorderRadius.circular(
      4.0,
    ),
  );
}

BoxDecoration homeDecor() {
  return BoxDecoration(
    color: Colors.black,
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.pink,
        Colors.orange,
      ],
    ),
    borderRadius: BorderRadius.circular(
      4.0,
    ),
  );
}
