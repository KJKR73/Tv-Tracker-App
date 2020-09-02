import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

// ignore: must_be_immutable
class WatchingWidget extends StatefulWidget {
  dynamic data;
  WatchingWidget({this.data});
  @override
  _WatchingWidgetState createState() => _WatchingWidgetState();
}

class _WatchingWidgetState extends State<WatchingWidget> {
  Future<dynamic> _getImage(body) async {
    var response = await post(
      "http://192.168.29.72:7000/misc/getimage",
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    );
    return base64.decode(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    Map body = {"series_id": widget.data["_id"]};
    return Container(
      padding: EdgeInsets.fromLTRB(3, 0, 3, 10),
      child: Column(
        children: [
          Expanded(
            flex: 9,
            child: FutureBuilder(
              future: _getImage(body),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Image.memory(
                      snapshot.data,
                      fit: BoxFit.cover,
                    ),
                  );
                } else {
                  return Container(
                    child: Center(
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  width: 1,
                  color: Colors.white,
                ),
                color: Colors.grey[850],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.data["name"],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}