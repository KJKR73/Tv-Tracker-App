import 'dart:convert';

import "package:flutter/material.dart";

class AddWidget extends StatelessWidget {
  String image64;
  String total;
  String name;
  String season;
  AddWidget({this.image64, this.total, this.name, this.season});
  @override
  Widget build(BuildContext context) {
    var image = base64.decode(this.image64);
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 245,
              child: ClipRRect(
                child: Image.memory(
                  image,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 245,
              color: Color.fromRGBO(32, 26, 48, 1),
              child: Padding(
                padding: EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Name: " + name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Total: " + total,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Season: " + season,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ButtonTheme(
                        minWidth: 50,
                        child: RaisedButton(
                          color: Color.fromRGBO(13, 245, 227, 1),
                          child: Text(
                            "Add",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
