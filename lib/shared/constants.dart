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